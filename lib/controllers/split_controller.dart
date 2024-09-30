import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sasrecords/models/product_model.dart';
import 'package:sasrecords/utils/utils.dart';

class SplitController with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductModel> splitData = [];

   bool _isLoading = false;
  bool get isLoading=> _isLoading;

  setLoading(bool value){
  _isLoading = value;
  notifyListeners();
  }

  Future<void> sendTostore(
    String itemCode,
    String itemName,
    String deliveryPerson,
    DateTime dateReceived,
    String quality,
    String batchNo,
    String lotNo,
    int quantity,
    String measuringUnit,
    String receivingperson,
    String department,
    String notes,
    BuildContext context
  ) async{
    setLoading(true);
    try {
      await firestore.collection('store').add({
        'itemcode': itemCode,
        'itemName': itemName,
        'deliveryperson': deliveryPerson,
        'dateReceived': dateReceived,
        'quality': quality,
        'batchNo': batchNo,
        'lotNo': lotNo,
        'quantity': quantity,
        'measuringUnit': measuringUnit,
        'department': department,
        'receivingperson': receivingperson,
        'notes': notes
      });
      setLoading(false);
      Utils.showPop(context);
    } catch (e) {
      setLoading(false);
    }
  }
   Future<void> fetchSplist()async{
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