import 'package:tap_todo/provider/firebase_api.dart';

import '../provider/product_provider.dart';

/* Mulitple repo provider*/
class Repository {
  static final Repository _repo = Repository._internal();

  late ProductProvider _productProvider;

  factory Repository() {
    return _repo;
  }

  Repository._internal() {
    _productProvider = ProductProvider();
  }

  ProductProvider get productProvider => _productProvider;
}
