import 'package:flutter/material.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/views/auth/form_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
       const FormWidget(),
      Padding(
        padding: EdgeInsets.only(right: width*0.1, ),
        child: SizedBox(
          height: height*0.95,
        //  width: width*0.45,
          child: Image.asset('assets/images/sidepic.jpg',),
        ),
      )
      ],),
    );
  }
}