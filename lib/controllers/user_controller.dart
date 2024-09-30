import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sasrecords/models/staff_model.dart';
import 'package:sasrecords/utils/utils.dart';

class UserController with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<StaffModel> staffData = [];
  List<StaffModel> payouts = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addStaff(
      String staffName,
      String staffID,
      String jobTitle,
      DateTime joiningDate,
      String department,
      String securityDeposit,
      String salary,
      int rate,
      String? notes,
      BuildContext context
      ) async {
    setLoading(true);
    try {
      await firestore.collection('staff').add({
        'staffName': staffName,
        'staffID': staffID,
        'jobTitle': jobTitle,
        'joiningDate': joiningDate,
        'securityDeposit': securityDeposit,
        'salary': salary,
        'rate': rate,
        'department': department,
        'notes': notes
      });
      setLoading(false);
      Utils.showPop(context);
    } catch (e) {
      setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addPayout(
      String staffName,
      String staffID,
      String jobTitle,
      DateTime fromDate,
      DateTime toDate,
      String department,
      String salary,
      int totalWork,
      int rate,
      String totalPayout,
      String? notes,
      BuildContext context
      ) async {
    setLoading(true);
    try {
      await firestore.collection('payouts').add({
        'staffName': staffName,
        'staffID': staffID,
        'jobTitle': jobTitle,
        'salary': salary,
        'totalWork': totalWork,
        'rate': rate,
        'totalPayout': totalPayout,
        'fromDate': fromDate,
        'toDate': toDate,
        'department': department,
        'notes': notes
      });
      setLoading(false);
      Utils.showPop(context);
    } catch (e) {
      setLoading(false);
    }
    notifyListeners();
  }

Future<void> fetchStaff()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('staff').get();
    staffData = snapshot.docs.map((doc) {
        return StaffModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPayout()async{
    try {
      QuerySnapshot snapshot = await firestore.collection('payouts').get();
    payouts = snapshot.docs.map((doc) {
        return StaffModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

}
