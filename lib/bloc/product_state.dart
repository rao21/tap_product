import 'package:meta/meta.dart';
import '../model/product_model.dart';

@immutable
abstract class ProductState {}

class InitializeProductState extends ProductState {}

class FetchingProductListState extends ProductState {}
class FetchingProductEmptyListState extends ProductState {}

class FetchedProductSuccessedState extends ProductState {
  final List<Product>? data;

  FetchedProductSuccessedState({this.data});
}

class FetchProductFailedState extends ProductState {
  final String? message;
  final int? errorcode;
  FetchProductFailedState({this.message, this.errorcode});
}

class AddingProductState extends ProductState {}

class AddedProductSuccessedState extends ProductState {
  final Product? data;
  AddedProductSuccessedState({this.data});
}

class AddedProductFailedState extends ProductState {
  final String? message;
  final int? errorcode;
  AddedProductFailedState({this.message, this.errorcode});
}
