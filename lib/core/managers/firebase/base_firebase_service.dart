import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
import 'package:car_tracking_app/core/model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirebaseService<T extends BaseModel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseCollectionName defaultCollection;

  BaseFirebaseService(this.defaultCollection);

  Future<void> addItem(
      T item, String id, Map<String, dynamic> Function(T) toJson,
      {FirebaseCollectionName? customCollection}) async {
    await _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .doc(id)
        .set(toJson(item));
  }

  Future<void> updateItem(
      T item, String id, Map<String, dynamic> Function(T) toJson,
      {FirebaseCollectionName? customCollection}) async {
    await _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .doc(id)
        .update(toJson(item));
  }

  Future<void> deleteItem(String id,
      {FirebaseCollectionName? customCollection}) async {
    await _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .doc(id)
        .delete();
  }

  Future<T?> getItem(String id, T Function(Map<String, dynamic>) fromJson,
      {FirebaseCollectionName? customCollection}) async {
    DocumentSnapshot doc = await _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .doc(id)
        .get();
    if (doc.exists) {
      return fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Stream<List<T>> getItemsAsStream(T Function(Map<String, dynamic>) fromJson,
      {FirebaseCollectionName? customCollection}) {
    return _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return fromJson(doc.data());
      }).toList();
    });
  }

  Future<List<T>> getItemsAsFuture(T Function(Map<String, dynamic>) fromJson,
      {FirebaseCollectionName? customCollection}) async {
    QuerySnapshot snapshot = await _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .get();
    return snapshot.docs.map((doc) {
      return fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
