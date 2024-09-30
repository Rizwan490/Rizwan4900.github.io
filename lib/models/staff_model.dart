import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StaffModel {
  String? staffName;
  String? staffID;
  String? jobTitle;
  DateTime? joiningDate;
  DateTime? fromDate;
  DateTime? toDate;
  String? department;
  String? securityDeposit;
  String? salary;
  int? totalWork;
  int? rate;
  String? totalPayout;
  String? notes;

  StaffModel(
      {required this.staffName,
      required this.staffID,
      required this.jobTitle,
      required this.joiningDate,
      required this.securityDeposit,
      required this.salary,
      required this.totalWork,
      required this.totalPayout,
      required this.rate,
      required this.fromDate,
      required this.toDate,
      required this.department,
      required this.notes});

  factory StaffModel.fromFirestore(Map<String, dynamic> data) {
    return StaffModel(
        staffName: data['staffName'] ?? '',
        staffID: data['staffID'] ?? '',
        jobTitle: data['jobTitle'] ?? '',
        joiningDate: data['joiningDate'] != null
            ? (data['joiningDate'] as Timestamp).toDate()
            : null,
        securityDeposit: data['securityDeposit'] ?? '',
        salary: data['salary'] ?? '',
        totalWork: data['totalWork'] ?? 0,
        totalPayout: data['totalPayout'] ?? '',
        rate: data['rate'] ?? 0,
        fromDate: data['fromDate'] != null
            ? (data['fromDate'] as Timestamp).toDate()
            : null,
        toDate: data['toDate'] != null
            ? (data['toDate'] as Timestamp).toDate()
            : null,
        department: data['department'] ?? '',
        notes: data['notes'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'staffName': staffName,
      'staffID': staffID,
      'jobTitle': jobTitle,
      'joiningDate':
          joiningDate != null ? Timestamp.fromDate(joiningDate!) : null,
      'securityDeposit': securityDeposit,
      'salary': salary,
      'totalWork': totalWork,
      'rate': rate,
      'totalPayout': totalPayout,
      'fromDate': fromDate != null ? Timestamp.fromDate(fromDate!) : null,
      'toDate': toDate != null ? Timestamp.fromDate(toDate!) : null,
      'department': department,
      'notes': notes
    };
  }

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(joiningDate!);
  }
}
