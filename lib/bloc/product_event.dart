import 'package:meta/meta.dart';

import '../model/product_model.dart';

@immutable
abstract class ProductEvent {}

class ProductFetchEvent extends ProductEvent {}

class ProductAddEvent extends ProductEvent {
  final Product data;
  ProductAddEvent({required this.data});
}

class ProductSearchEvent extends ProductEvent {
  final String query;
  ProductSearchEvent({required this.query});
}
