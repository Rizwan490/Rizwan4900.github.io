import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/controllers/purchase_controller.dart';
import 'package:sasrecords/models/product_model.dart';
import 'package:sasrecords/widgets/custom_form.dart';
import 'package:sasrecords/widgets/small_textfield.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  TextEditingController itemCode = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController vendorName = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? dateReceived;
  TextEditingController paymentType = TextEditingController();
  TextEditingController batchNo = TextEditingController();
  TextEditingController lotNo = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController reqName = TextEditingController();
  TextEditingController reqDep = TextEditingController();
  TextEditingController invoiceNo = TextEditingController();
  TextEditingController approveName = TextEditingController();
  TextEditingController notes = TextEditingController();
  String value = '';
  List<int> list = [10, 25, 50, 100];
  int selected = 10;
  int? _sortColumnIndex;
  bool _isAscending = true;

  final List<String> units = ['KG','Feet', 'Meter', 'CM', 'Ton', 'Inches', 'Liter', 'Pieces'];
  String? measuringUnit;

  final _formKey = GlobalKey<FormState>();
  final PurchaseController controller = PurchaseController();

  Future<void> _selectDate(BuildContext context) async {
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
        dateReceived = pickedDate;
        dateController.text = formattedDate; // Set the selected date
      });
    }
  }

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
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                child: Container(
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
                      InkWell(
                        onTap: () {
                          // provider.selecteIndex(10);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(),));
                        },
                        child: Container(
                          width: width * 0.1,
                          height: height * 0.08,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomForm(
                            labelText: "Item Code",
                            textController: itemCode,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                            
                            
                          ),
                          CustomForm(
                            labelText: 'Item Name',
                            textController: itemName,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                           
                          ),
                          CustomForm(
                            labelText: 'Vendor Name',
                            textController: vendorName,
                            validator: (value) {
            if (value==null || value.isEmpty) {
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
                          SizedBox(
                            height: height * 0.15,
                            width: width * 0.17,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date Recieved",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.textfieldColor,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      suffixIcon:
                                          const Icon(Icons.calendar_today),
                                      filled: true,
                                      fillColor: AppColors.textfieldColor,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                      
                                )
                              ],
                            ),
                          ),
                          SmallTextfield(
                            labelText: 'Payment Type',
                            textController: paymentType,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                            
                          ),
                          SmallTextfield(
                            labelText: 'Batch No',
                            textController: batchNo,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                           
                          ),
                          SmallTextfield(
                            labelText: 'Lot No',
                            textController: lotNo,
                            validator: (value) {
            if (value==null || value.isEmpty) {
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
                            labelText: 'Quantity',
                            textController: quantitycontroller,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
              
            }
            final num? quantity = num.tryParse(value);
              if (quantity == null || quantity <= 0) {
                return 'Please enter a valid quantity';
              }
            return null;
          },
                           
                          ),
                          SizedBox(
                        height: height* 0.15,
                        width: width*0.17,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Measuring Unit", style: GoogleFonts.poppins(color: AppColors.textfieldColor, fontSize: 16),),
                          const SizedBox(height: 5,),
                          DropdownButtonFormField<String>(
                      value: measuringUnit,
                      hint: const Text('Measuring Unit'),
                      items: units.map((String measuringUnit){
                        return DropdownMenuItem(
                          value: measuringUnit,
                          child: Text(measuringUnit));
                      }).toList(), onChanged: (value) {
                        setState(() {
                          measuringUnit = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textfieldColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none)
                      ),
                      validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                     
                      ),
                         
                        ],),
                      ),
                          SmallTextfield(
                            labelText: 'Requester Name',
                            textController: reqName,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                           
                          ),
                          SmallTextfield(
                            labelText: 'Requester Department',
                            textController: reqDep,
                            validator: (value) {
            if (value==null || value.isEmpty) {
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
                          SmallTextfield(
                            labelText: 'Invoice No',
                            textController: invoiceNo,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                            
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SmallTextfield(
                            labelText: 'Approve Name',
                            textController: approveName,
                            validator: (value) {
            if (value==null || value.isEmpty) {
              return "This field can't be empty";
            }
            return null;
          },
                           
                          ),
                        ],
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
                                    color: AppColors.textfieldColor,
                                    fontSize: 16),
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
                                      filled: true,
                                      fillColor: AppColors.textfieldColor),
                                ),
                              ),
                            ],
                          ),
                          Consumer<PurchaseController>(builder: (context, value, child) {
                            return InkWell(
                            onTap: () {
                            submit();
                            },
                            child: Container(
                              width: width * 0.1,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: AppColors.redButton,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: 
                                value.isLoading ? const CircularProgressIndicator(color: Colors.white,) :
                                 Text(
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
                          },)
                          
                        ],
                      ),

                      const SizedBox(height: 50,),
                      
                      controller.purchaseData.isEmpty?
                       Center(child: CircularProgressIndicator(color: AppColors.textfieldColor,),)
                      :
                      Container(
                        width: width,
                        height: height*0.9,
                        decoration: BoxDecoration(
                          color: AppColors.textfieldColor
                        ),
                        child: SingleChildScrollView(
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
          ),
        )
      ],
    );
  }

  Future<void> submit() async {
    
    if (_formKey.currentState!.validate()) {
      int quantity = int.parse(quantitycontroller.text);
       await Provider.of<PurchaseController>(context, listen: false).enterData(
        itemCode.text,
        itemName.text,
        vendorName.text,
        dateReceived!,
        paymentType.text,
        batchNo.text,
        lotNo.text,
        quantity,
        measuringUnit!,
        reqName.text,
        reqDep.text,
        invoiceNo.text,
        approveName.text,
        notes.text,
        context
        );
    }
   
  }
}
