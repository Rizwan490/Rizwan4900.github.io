import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  
  static showPop(BuildContext context){
    return showDialog(context: context, builder: (context) => SimpleDialog(
      children: [
        Container(
          height: 300,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Image.asset('assets/images/success.png', width: 100,),
                   SizedBox(height: 30,),
                    Text('Data Submited Successsfuly!', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),),
                    SizedBox(height: 40,),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Close'))
            ],),
          ),
        ),
        
      ],
    ),);
  }
}