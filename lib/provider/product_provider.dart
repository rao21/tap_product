import 'package:tap_todo/model/product_model.dart';
import 'package:tap_todo/provider/firebase_api.dart';
import 'package:tap_todo/utils/constants.dart';

class ProductProvider {
  final FirebaseApi _api = FirebaseApi(FireBaseCollectionsName.products);

  Future<List<Product>> fetchTodoItems() async {
    try {
      var result = await _api.getDataCollection();
      List<Product> todos = result.docs.isNotEmpty
          ? result.docs
              .map((doc) => Product.fromMap(doc.data() as Map, doc.id))
              .toList()
          : [];
      return todos;
    } catch (exp) {
      rethrow;
    }
  }

  Future<dynamic> addProduct({Product? obj}) async {
    try {
      var result = await _api.addDocument(obj!.toJson());
      return result;
    } catch (exp) {
      rethrow;
    }
  }
}
