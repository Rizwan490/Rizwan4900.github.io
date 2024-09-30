import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sasrecords/models/product_model.dart';
import 'package:sasrecords/utils/utils.dart';

class StoreController with ChangeNotifier{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProductModel> data = [];

   bool _isLoading = false;
  bool get isLoading=> _isLoading;

  setLoading(bool value){
  _isLoading = value;
  notifyListeners();
  }


Future<void> storeData(
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
        'receivingperson': receivingperson,
        'notes': notes
    });
    setLoading(false);
    Utils.showPop(context);
  } catch (e) {
    setLoading(false);
  }
  notifyListeners();
}

Future<void> storeOutData(
  String itemCode,
    String itemName,
    String deliveryPerson,
    DateTime dateReceived,
    String quality,
    String batchNo,
    String lotNo,
    int quantity,
    String measuringUnit,
    String authPerson,
    String department,
    String notes,
    BuildContext context
) async{
  setLoading(true);

  try {
    QuerySnapshot snapshot = await firestore.collection('store').where('batchNo', isEqualTo: batchNo).get();
    if (snapshot.docs.isEmpty) {
      throw Exception('Batch not found');
    }

    DocumentSnapshot batchDoc = snapshot.docs.first;
    int existQuantity = batchDoc['quantity'];
    print(existQuantity);
    print(quantity);
    print(department);

    if (quantity > existQuantity) {
      throw Exception('Requested quantity exceeds available stock');
    }

    int updatedQuantity = existQuantity - quantity;

    await firestore.collection('store').doc(batchDoc.id).update({
      'quantity': updatedQuantity
    });

    await firestore.collection(department).add({
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
        'authorizedperson': authPerson,
        'notes': notes
    });
setLoading(false);
Utils.showPop(context);



  } catch (e) {
    print(e.toString());
    setLoading(false);
  }
  notifyListeners();
}

Future<void> fetchStoreData() async{
  try {
      QuerySnapshot snapshot = await firestore.collection('store').get();
    data = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
}

}