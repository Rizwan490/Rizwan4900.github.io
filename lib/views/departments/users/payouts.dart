import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/controllers/user_controller.dart';
import 'package:sasrecords/models/staff_model.dart';
import 'package:sasrecords/widgets/custom_form.dart';
import 'package:sasrecords/widgets/small_textfield.dart';

class Payouts extends StatefulWidget {
  const Payouts({super.key});

  @override
  State<Payouts> createState() => _PayoutsState();
}

class _PayoutsState extends State<Payouts> {
  TextEditingController staffName = TextEditingController();
  TextEditingController staffID = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController totalPayout = TextEditingController();
  TextEditingController notes = TextEditingController();
  DateTime? toDate;
  DateTime? fromDate;

  List<int> list = [10, 25, 50, 100];
  int selected = 10;

  final _formKey = GlobalKey<FormState>();

  UserController controller = UserController();

  Future<void> _selectDate(BuildContext context, String value) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Formatting the date and updating the controller
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        toDateController.text = formattedDate; // Set the selected date
        toDate = pickedDate;
      });
    }
  }

  Future<void> _fromDate(BuildContext context, String value) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Formatting the date and updating the controller
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        fromDateController.text = formattedDate; // Set the selected date
        fromDate = pickedDate;
      });
    }
  }

  int? _sortColumnIndex;
  bool _isAscending = true;

  Future<void> fetchData() async {
    try {
      await controller.fetchPayout();
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void _sort<T>(Comparable<T> Function(StaffModel) getField, int columnIndex,
      bool ascending) {
    controller.payouts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomForm(
                labelText: "Staff Name",
                textController: staffName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
              CustomForm(
                labelText: 'Staff Id',
                textController: staffID,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
              CustomForm(
                labelText: 'Job Title',
                textController: jobTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallTextfield(
                labelText: 'Department',
                textController: department,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
              SmallTextfield(
                labelText: 'Salary',
                textController: salary,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
              SmallTextfield(
                labelText: 'Rate',
                textController: rateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
              SmallTextfield(
                labelText: 'Total Work/Task',
                textController: workController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                height: height * 0.15,
                width: width * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From Date",
                      style: GoogleFonts.poppins(
                          color: AppColors.textfieldColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: fromDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today),
                          filled: true,
                          fillColor: AppColors.textfieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                      onTap: () {
                        _fromDate(context, fromDateController.text);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: height * 0.15,
                width: width * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To Date",
                      style: GoogleFonts.poppins(
                          color: AppColors.textfieldColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: toDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today),
                          filled: true,
                          fillColor: AppColors.textfieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                      onTap: () {
                        _selectDate(context, toDateController.text);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SmallTextfield(
                labelText: 'Total Payout',
                textController: totalPayout,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes or Refrenece",
                    style: GoogleFonts.poppins(
                        color: AppColors.textfieldColor, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: TextFormField(
                      controller: notes,
                      maxLines: 5,
                      minLines: 3,
                      decoration: InputDecoration(
                          filled: true, fillColor: AppColors.textfieldColor),
                    ),
                  ),
                ],
              ),
              Consumer<UserController>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      addPayout();
                    },
                    child: Container(
                      width: width * 0.1,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                          color: AppColors.redButton,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: value.isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Enter',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textfieldColor,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          controller.payouts.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.textfieldColor,
                  ),
                )
              : Container(
                  width: width,
                  height: height * 0.9,
                  decoration: BoxDecoration(color: AppColors.textfieldColor),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        decoration: BoxDecoration(
                          color: AppColors.textfieldColor,
                        ),
                        columnSpacing: 4,
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _isAscending,
                        columns: [
                          DataColumn(
                            label: Text(
                              "Staff Name",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.staffName.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Staff ID",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.staffID.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Job Title",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.jobTitle.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Department",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.department.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Salary",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.salary.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Rate",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.rate.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Total Work",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.totalWork.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "From Date",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.fromDate.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "To Date",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.toDate.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Total Payout",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.totalPayout.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                          DataColumn(
                            label: Text(
                              "Notes",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            onSort: (columnIndex, ascending) {
                              _sort<String>(
                                  (purchase) => purchase.notes.toString(),
                                  columnIndex,
                                  ascending);
                            },
                          ),
                        ],
                        rows: controller.payouts.map((purchase) {
                          return DataRow(cells: [
                            DataCell(Text(purchase.staffName.toString())),
                            DataCell(Text(purchase.staffID.toString())),
                            DataCell(Text(purchase.jobTitle.toString())),
                            DataCell(Text(purchase.department.toString())),
                            DataCell(Text(purchase.salary.toString())),
                            DataCell(Text(purchase.rate.toString())),
                            DataCell(Text(purchase.totalWork.toString())),
                            DataCell(Text(purchase.fromDate != null
                                ? purchase.fromDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0]
                                : 'N/A')),
                            DataCell(Text(purchase.toDate != null
                                ? purchase.toDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0]
                                : 'N/A')),
                            DataCell(Text(purchase.totalPayout.toString())),
                            DataCell(Text(purchase.notes.toString())),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> addPayout() async {
    if (_formKey.currentState!.validate()) {
      int rate = int.parse(rateController.text);
      int totalWork = int.parse(workController.text);
      Provider.of<UserController>(context, listen: false).addPayout(
          staffName.text,
          staffID.text,
          jobTitle.text,
          fromDate!,
          toDate!,
          department.text,
          salary.text,
          totalWork,
          rate,
          totalPayout.text,
          notes.text,
          context
          );

      _formKey.currentState!.reset();
    }
  }
}
