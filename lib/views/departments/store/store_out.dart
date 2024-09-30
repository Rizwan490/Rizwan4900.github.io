import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/controllers/store_controller.dart';
import 'package:sasrecords/widgets/custom_form.dart';
import 'package:sasrecords/widgets/small_textfield.dart';

class StoreOut extends StatefulWidget {
  const StoreOut({super.key});

  @override
  State<StoreOut> createState() => _StoreOutState();
}

class _StoreOutState extends State<StoreOut> {
  TextEditingController itemCode = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController deliveryPerson = TextEditingController();
  DateTime? dateReceived;
  TextEditingController dateController = TextEditingController();
  TextEditingController quality = TextEditingController();
  TextEditingController batchNo = TextEditingController();
  TextEditingController lotNo = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController authPerson = TextEditingController();
  TextEditingController notes = TextEditingController();
  String value = '';
  List<int> list = [10, 25, 50, 100];
  int selected = 10;
  final _formKey = GlobalKey<FormState>();

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

  final List<String> units = [
    'KG',
    'Feet',
    'Meter',
    'CM',
    'Ton',
    'Inches',
    'Liter',
    'Pieces'
  ];
  String? measuringUnit;

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                height: height * 0.15,
                width: width * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data Received",
                      style: GoogleFonts.poppins(
                          color: AppColors.textfieldColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today),
                          filled: true,
                          fillColor: AppColors.textfieldColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
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
                  ],
                ),
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
                height: height * 0.15,
                width: width * 0.17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Measuring Unit",
                      style: GoogleFonts.poppins(
                          color: AppColors.textfieldColor, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownButtonFormField<String>(
                      value: measuringUnit,
                      hint: const Text('Measuring Unit'),
                      items: units.map((String measuringUnit) {
                        return DropdownMenuItem(
                            value: measuringUnit, child: Text(measuringUnit));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          measuringUnit = value;
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
                labelText: 'Authorized Person',
                textController: authPerson,
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
              Consumer<StoreController>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      storeOut();
                    },
                    child: Container(
                      width: width * 0.1,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                          color: AppColors.redButton,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: value.isLoading
                            ? const CircularProgressIndicator()
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
        ],
      ),
    );
  }

  Future<void> storeOut() async {
    if (_formKey.currentState!.validate()) {
      int quantity = int.parse(quantityController.text);
      await Provider.of<StoreController>(context, listen: false).storeOutData(
          itemCode.text,
          itemName.text,
          deliveryPerson.text,
          dateReceived!,
          quality.text,
          batchNo.text,
          lotNo.text,
          quantity,
          measuringUnit!,
          authPerson.text,
          department!,
          notes.text,
          context
          );
    }
  }
}
