import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasrecords/constants/app_colors.dart';

class ReadyStocks extends StatelessWidget {
  const ReadyStocks({super.key});

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
                height: height*0.90,
                width: width,
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                   
                   
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
    );
  }
}