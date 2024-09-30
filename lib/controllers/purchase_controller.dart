import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sasrecords/models/product_model.dart';
import 'package:sasrecords/utils/utils.dart';

class PurchaseController with ChangeNotifier {
  CollectionReference ref = FirebaseFirestore.instance.collection('purchase');
  bool _isLoading = false;
  bool get isLoading=> _isLoading;

  setLoading(bool value){
  _isLoading = value;
  notifyListeners();
  }

  List<ProductModel> purchaseData = [];

  Future<void> enterData(
    String itemcode,
    String itemName,
    String vendorName,
    DateTime dateReceived,
    String paymentType,
    String batchNo,
    String lotNo,
    int quantity,
    String measuringUnit,
    String requesterName,
    String requesterDep,
    String invoiceNo,
    String proveName,
    String notes,
    BuildContext context
  ) async {
    setLoading(true);
    try {
      await ref.add({
        'itemcode': itemcode,
        'itemName': itemName,
        'vendorName': vendorName,
        'dateReceived': dateReceived,
        'paymentType': paymentType,
        'batchNo': batchNo,
        'lotNo': lotNo,
        'quantity': quantity,
        'measuringUnit': measuringUnit,
        'requesterName': requesterName,
        'requesterDep': requesterDep,
        'invoiceNo': invoiceNo,
        'proveName': proveName,
        'notes': notes
      });
      setLoading(false);
      Utils.showPop(context);
    } catch (e) {
      setLoading(false);
    }
    notifyListeners();
  }

  Future<void> fetchPurchase() async{
    
    try {
      QuerySnapshot snapshot = await ref.get();
    purchaseData = snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
    
  }


}
