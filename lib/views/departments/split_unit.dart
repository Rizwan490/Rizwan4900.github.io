import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/controllers/split_controller.dart';
import 'package:sasrecords/models/product_model.dart';
import 'package:sasrecords/widgets/custom_form.dart';
import 'package:sasrecords/widgets/small_textfield.dart';

class SplitUnit extends StatefulWidget {
  const SplitUnit({super.key});

  @override
  State<SplitUnit> createState() => _SplitUnitState();
}

class _SplitUnitState extends State<SplitUnit> {

TextEditingController itemCode = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController deliveryPerson = TextEditingController();
  DateTime? dateReceived;
  TextEditingController dateController = TextEditingController();
  TextEditingController quality = TextEditingController();
  TextEditingController batchNo = TextEditingController();
  TextEditingController lotNo = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController receivingperson = TextEditingController();
  TextEditingController notes = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<String> units = ['KG','Feet', 'Meter', 'CM', 'Ton', 'Inches', 'Liter', 'Pieces'];
  String? measuringUnit;
final List<String> departments = [
    'Drum Unit',
    'Shaver Unit',
    'Buff Unit',
    'Cutting Unit',
    'Split Unit',
    'Stitching Unit',
    'Qc Unit'
  ];
  String? department;

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
        dateController.text = formattedDate;
        dateReceived = pickedDate; // Set the selected date
      });
    }
  }


  final SplitController controller = SplitController();
  int? _sortColumnIndex;
  bool _isAscending = true;

  Future<void> fetchData() async {
    try {
      await controller.fetchSplist();
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
    controller.splitData.sort((a, b) {
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

void clearFields(){
    itemCode.clear();
    itemName.clear();
    deliveryPerson.clear();
    dateController.clear();
    dateReceived = null;
    quality.clear();
    batchNo.clear();
    lotNo.clear();
    quantityController.clear();
    notes.clear();
    
    
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
              child: Container(
                width: width * 0.9,
                
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.1,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                            color: AppColors.redButton,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Split Unit',
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                      Column(children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomForm(
                            labelText: "Item Code",
                            textController: itemCode,
                            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                          ),
                          CustomForm(
                            labelText: 'Item Name',
                            textController: itemName,
                            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                          ),
                          CustomForm(
                            labelText: 'Delivery Person',
                            textController: deliveryPerson,
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
                          SizedBox(
                      height: height* 0.15,
                      width: width*0.17,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Data Received", style: GoogleFonts.poppins(color: AppColors.textfieldColor, fontSize: 16),),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.calendar_today),
                            filled: true,
                            fillColor: AppColors.textfieldColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                          validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                        )
                      ],),
                          ),
                          
                          SmallTextfield(
                            labelText: 'Batch No',
                            textController: batchNo,
                            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                          ),
                          SmallTextfield(
                            labelText: 'Lot No',
                            textController: lotNo,
                            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                          ),
                          SmallTextfield(
                            labelText: 'Quality',
                            textController: quality,
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
                            labelText: 'Quantity',
                            textController: quantityController,
                            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
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
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                      ),
                       
                      ],),
                          ),
                          
                          SizedBox(
                height: height * 0.15,
                width: width * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Department",
                      style: GoogleFonts.poppins(
                          color: AppColors.textfieldColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField<String>(
                      value: department,
                      hint: const Text('Select Department'),
                      items: departments.map((String department) {
                        return DropdownMenuItem(
                            value: department, child: Text(department));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          department = value;
                        });
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.textfieldColor,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
                          SmallTextfield(
                            labelText: 'Receiving Person',
                            textController: receivingperson,
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
                          Consumer<SplitController>(builder: (context, value, child) {
                            return  InkWell(
                              onTap: () {
                              sendData();
                              
                              },
                            child: Container(
                              width: width * 0.1,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: AppColors.redButton,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: value.isLoading ? const CircularProgressIndicator()
                                :
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
                      
                          ],),
                      
                          const SizedBox(height: 30,),
                      
                      controller.splitData.isEmpty?
                       Center(child: CircularProgressIndicator(color: Colors.white,),)
                      :
                      Container(
                         height: height*0.9,
                        width: width,
                        decoration: BoxDecoration(color: AppColors.textfieldColor),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              decoration:
                                  BoxDecoration(color: AppColors.textfieldColor, ),
                              
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
                                  "Authorized Person",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
                                ),
                                onSort: (columnIndex, ascending) {
                                    _sort<String>((purchase) => purchase.authorizedperson.toString(),
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
                              rows: controller.splitData.map((purchase) {
                                return DataRow(cells: [
                                  DataCell(Text(purchase.batchNo.toString())),
                                  
                                  DataCell(Text(purchase.itemcode.toString())),
                                  DataCell(Text(purchase.itemName.toString())),
                                 
                                  DataCell(Text(purchase.dateReceived != null 
                                ? purchase.dateReceived!.toLocal().toString().split(' ')[0]
                                : 'N/A')),
                                 
                                  DataCell(Text(purchase.lotNo.toString())),
                                  DataCell(Text(purchase.quantity.toString())),
                                  DataCell(Text(purchase.measuringUnit.toString())),
                                 
                                  
                                  DataCell(Text(purchase.authorizedperson.toString())),
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
    );
  }
  Future<void> sendData() async {
    if (_formKey.currentState!.validate()) {
      int quantity = int.parse(quantityController.text);
      await Provider.of<SplitController>(context, listen: false).sendTostore(
          itemCode.text,
          itemName.text,
          deliveryPerson.text,
          dateReceived!,
          quality.text,
          batchNo.text,
          lotNo.text,
          quantity,
          measuringUnit!,
          receivingperson.text,
          department!,
          notes.text,
          context
          );
    }
  }
  
}
