import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sasrecords/models/product_model.dart';

class DataController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ProductModel> buffData = [];
  List<ProductModel> shaverData = [];
  List<ProductModel> drumData = [];
  List<ProductModel> splitData = [];
  List<ProductModel> cuttingData = [];
  List<ProductModel> stitchingData = [];

  Future<void> fetchBuff()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('Buff Unit').get();
    buffData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

   Future<void> fetchShaver()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('Shaver Unit').get();
    shaverData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchDrum()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('Drum Unit').get();
    drumData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchStiching()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('Stiching Unit').get();
    stitchingData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCutting()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('Cutting Unit').get();
    cuttingData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchSplit()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('Split Unit').get();
    splitData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }
}