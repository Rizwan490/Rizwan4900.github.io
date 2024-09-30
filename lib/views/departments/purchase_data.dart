import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/controllers/purchase_controller.dart';
import 'package:sasrecords/models/product_model.dart';

class PurchaseData extends StatefulWidget {
  const PurchaseData({super.key});

  @override
  State<PurchaseData> createState() => _PurchaseDataState();
}

class _PurchaseDataState extends State<PurchaseData> {
  final PurchaseController controller = PurchaseController();
  int? _sortColumnIndex;
  bool _isAscending = true;

  Future<void> fetchData() async {
    try {
      await controller.fetchPurchase();
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

  void _sort<T>(Comparable<T> Function(ProductModel) getField, int columnIndex,
      bool ascending) {
    controller.purchaseData.sort((a, b) {
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
    return Scrollbar(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                child: Container(
                  width: width * 0.9,
                  height: height*0.95,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.1,
                        height: height * 0.09,
                        decoration: BoxDecoration(
                            color: AppColors.redButton,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Purchase',
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textfieldColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      controller.purchaseData.isEmpty?
                      const Center(child: CircularProgressIndicator(),)
                      :
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            decoration:
                                BoxDecoration(color: AppColors.textfieldColor, ),
                            columnSpacing: 2,
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: _isAscending,
                            columns: [
                              DataColumn(
                                label: Text(
                                "Batch NO",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                                                                  ),
                                onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.batchNo.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Invoice No",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.invoiceNo.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Item Code",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.itemcode.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Item Name",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.itemName.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Vendor Name",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.vendorName.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Date Received",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.dateReceived.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Payment Type",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.paymentType.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Lot No",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.lotNo.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Quantity",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.quantity.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Measuring Unit",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.measuringUnit.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Requester Name",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.requesterName.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Requester Department",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.requesterDep.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Approve Name",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.proveName.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                              DataColumn(
                                  label: Text(
                                "Notes or Refrence",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              onSort: (columnIndex, ascending) {
                                  _sort<String>((purchase) => purchase.notes.toString(),
                                      columnIndex, ascending);
                                },
                              ),
                            ],
                            rows: controller.purchaseData.map((purchase) {
                              return DataRow(cells: [
                                DataCell(Text(purchase.batchNo.toString())),
                                DataCell(Text(purchase.invoiceNo.toString())),
                                DataCell(Text(purchase.itemcode.toString())),
                                DataCell(Text(purchase.itemName.toString())),
                                DataCell(Text(purchase.vendorName.toString())),
                                DataCell(Text(purchase.dateReceived != null 
              ? purchase.dateReceived!.toLocal().toString().split(' ')[0]
              : 'N/A')),
                                DataCell(Text(purchase.paymentType.toString())),
                                DataCell(Text(purchase.lotNo.toString())),
                                DataCell(Text(purchase.quantity.toString())),
                                DataCell(Text(purchase.measuringUnit.toString())),
                                DataCell(Text(purchase.requesterName.toString())),
                                DataCell(Text(purchase.requesterDep.toString())),
                                DataCell(Text(purchase.proveName.toString())),
                                DataCell(Text(purchase.notes.toString())),
                                
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: height * 0.1,
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.backGroundColor,
                ),
                child: Center(
                  child: Text(
                    '2024 © Shakeel and Sons',
                    style: GoogleFonts.poppins(color: AppColors.textfieldColor),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
