import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasrecords/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.btnText, required this.action});
  final String btnText;
  final void Function() action;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: action,
      child: Container(
        height: height* 0.08,
        width: width*0.22,
        decoration: BoxDecoration(
          color: AppColors.textfieldColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text(btnText, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),)),
      ),
    );
  }
}
