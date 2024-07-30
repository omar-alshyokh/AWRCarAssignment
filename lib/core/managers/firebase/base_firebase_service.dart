import 'package:car_tracking_app/core/managers/firebase/firebase_constants.dart';
import 'package:car_tracking_app/core/model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

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

  Future<T?> getItem(String id, FromJson<T> fromJson,
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

  Stream<T?> getItemAsStream(String id, FromJson<T> fromJson,
      {FirebaseCollectionName? customCollection}) {
    return _firestore
        .collection(customCollection?.name ?? defaultCollection.name)
        .doc(id)
        .snapshots()
        .map((snapshot) => snapshot.exists
            ? fromJson(snapshot.data() as Map<String, dynamic>)
            : null);
  }

  Stream<List<T>> getItemsAsStream(FromJson<T> fromJson,
      {FirebaseCollectionName? customCollection,
      Query Function(Query)? queryBuilder}) {
    Query query = FirebaseFirestore.instance
        .collection(customCollection?.name ?? defaultCollection.name);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<T>> getItemsAsFuture(FromJson<T> fromJson,
      {FirebaseCollectionName? customCollection,
      Query Function(Query)? queryBuilder}) async {
    Query query = FirebaseFirestore.instance
        .collection(customCollection?.name ?? defaultCollection.name);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    QuerySnapshot snapshot = await query.get();
    return snapshot.docs
        .map((doc) => fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
