import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/controllers/auth_controller.dart';


class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthController auth = AuthController();
  @override
  Widget build(BuildContext context) {
   // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 100),
      child: SizedBox(
        width: width*0.32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/mylogo.png',
              width: 200,
            ),
            const SizedBox(height: 40,),
            Text(
              "Internal ERP & Audit Panel",
              style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w500, color: AppColors.textfieldColor),
            ),
            const SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.poppins(color: AppColors.textfieldColor, fontSize: 18),
                ),
                SizedBox(
                  width: width*0.2,
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textfieldColor,
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pasword",
                  style: GoogleFonts.poppins(color: AppColors.textfieldColor, fontSize: 18),
                ),
                SizedBox(
                   width: width*0.2,
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textfieldColor,
                        border:
                            const OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            
            SizedBox(
              height: 50,
              width: 160,
              child: Consumer<AuthController>(builder: (context, value, child) {
              return InkWell(
              onTap: () {
                userSignin();
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(color: AppColors.redButton, borderRadius: BorderRadius.circular(10)),
                child: Center(child: value.isLoading? const CircularProgressIndicator(color: Colors.white,) : Text('Login', style: GoogleFonts.poppins(color: AppColors.textfieldColor, fontSize: 18),)),
              ),
                            ) ;
            },)
            )
            

          ],
        ),
      ),
    );
  }
  Future<void> userSignin () async{
   await Provider.of<AuthController>(context, listen: false).userLogin(email.text, password.text, context);
  }
}
