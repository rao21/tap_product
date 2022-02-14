import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirebaseApi {
  final FirebaseFirestore? _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference? ref;

  FirebaseApi(this.path) {
    ref = _db!.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref!.get();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref!.add(data);
  }
}
