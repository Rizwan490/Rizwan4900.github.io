import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProductModel {
  String? itemcode;
  String? itemName;
  String? vendorName;
  DateTime? dateReceived;
  String? paymentType;
  String? batchNo;
  String? lotNo;
  int? quantity;
  String? measuringUnit;
  String? requesterName;
  String? requesterDep;
  String? invoiceNo;
  String? proveName;
  String? authorizedperson;
  String? department;
  String? quality;
  String? receivingperson;
  String? deliveryperson;
  String? notes;

  ProductModel(
      {required this.itemcode,
      required this.itemName,
      required this.vendorName,
      required this.dateReceived,
      required this.paymentType,
      required this.batchNo,
      required this.lotNo,
      required this.quality,
      required this.measuringUnit,
      required this.requesterDep,
      required this.requesterName,
      required this.invoiceNo,
      required this.proveName,
      required this.quantity,
      required this.department,
      required this.authorizedperson,
      required this.receivingperson,
      required this.deliveryperson,
      required this.notes});

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
        itemcode: data['itemcode'] ?? '',
        itemName: data['itemName'] ?? '',
        vendorName: data['vendorName'] ?? '',
        dateReceived: data['dateReceived'] != null ? 
                    (data['dateReceived'] as Timestamp).toDate() : null ,
        paymentType: data['paymentType'] ?? '',
        batchNo: data['batchNo'] ?? '',
        lotNo: data['lotNo'] ?? '',
        quality: data['quality'] ?? '',
        measuringUnit: data['measuringUnit'] ?? '',
        requesterDep: data['requesterDep'] ?? '',
        requesterName: data['requesterName'] ?? '',
        invoiceNo: data['invoiceNo'] ?? '',
        proveName: data['proveName'] ?? '',
        quantity: data['quantity'] ?? 0,
        department: data['department'] ?? '',
        authorizedperson: data['authorizedperson'] ?? '',
        receivingperson: data['receivingperson'] ?? '',
        deliveryperson: data['deliveryPerson'] ?? '',
        notes: data['notes'] ?? '');
  }

  Map<String, dynamic> toMap(){
    return{
      'itemcode': itemcode,
        'itemName': itemName,
        'vendorName': vendorName,
        'dateReceived': dateReceived != null ? 
                      Timestamp.fromDate(dateReceived!) : null,
        'paymentType': paymentType,
        'batchNo': batchNo,
        'lotNo': lotNo,
        'quantity': quantity,
        'measuringUnit': measuringUnit,
        'requesterName': requesterName,
        'requesterDep': requesterDep,
        'invoiceNo': invoiceNo,
        'proveName': proveName,
        'quality': quality,
        'receivingperson': receivingperson,
        'deliveryperson': deliveryperson,
        'authorizedperson': authorizedperson,
        'notes': notes
    };
  } 
  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(dateReceived!);
  }
}
