import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tap_todo/model/product_model.dart';
import 'package:tap_todo/provider/product_provider.dart';
import 'package:tap_todo/repository/repository.dart';

import 'bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductProvider productProvider = Repository().productProvider;
  ProductBloc({required ProductState initialState}) : super(initialState);

  late List<Product> _products;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFetchEvent) {
      yield FetchingProductListState();
      try {
        List<Product> _result = await productProvider.fetchTodoItems();
        if (_result.isEmpty) {
          yield FetchingProductEmptyListState();
        } else {
          _products = _result;
          yield FetchedProductSuccessedState(data: _result);
        }
      } catch (e) {
        yield FetchProductFailedState(
            message: 'Failed to load data', errorcode: 400);
      }
    }
    if (event is ProductAddEvent) {
      yield AddingProductState();
      try {
        var _result = await productProvider.addProduct(obj: event.data);
        yield AddedProductSuccessedState(data: event.data);
      } catch (e) {
        yield AddedProductFailedState(message: 'Failed to add data');
      }
    }
    if (event is ProductAddEvent) {
      yield AddingProductState();
      try {
        var _result = await productProvider.addProduct(obj: event.data);
        yield AddedProductSuccessedState(data: event.data);
      } catch (e) {
        yield AddedProductFailedState(message: 'Failed to add data');
      }
    }
    if (event is ProductSearchEvent) {
      yield FetchingProductListState();
      try {
        List<Product> _result;
        if (event.query.isEmpty) {
          _result = await productProvider.fetchTodoItems();
          _products = _result;
          yield FetchedProductSuccessedState(data: _result);
        }
        if (_products.isNotEmpty && event.query.isNotEmpty) {
          _result = _products
              .where((e) =>
                  e.name!.toLowerCase().contains(event.query.toLowerCase()) ||
                  e.description!
                      .toLowerCase()
                      .contains(event.query.toLowerCase()) ||
                  e.price!.toString().contains(event.query.toLowerCase()))
              .toList();
          print(_result.toString());
          _products = _result;
          
          yield FetchedProductSuccessedState(data: _result);
        }
      } catch (exp) {
        yield FetchProductFailedState(
            message: 'Failed to load data', errorcode: 400);
      }
    }
  }
}
