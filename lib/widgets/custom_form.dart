import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasrecords/constants/app_colors.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key, required this.labelText, required this.textController, this.validator});
  final String labelText;
  final  TextEditingController textController;
  final String? Function(String?)? validator;
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height* 0.15,
      width: width*0.23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(labelText, style: GoogleFonts.poppins(color: AppColors.textfieldColor, fontSize: 16),),
       const SizedBox(height: 5,),
        TextFormField(
          controller: textController,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textfieldColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)
            )
          ),
          validator: validator,
          
        )
      ],),
    );
  }
}