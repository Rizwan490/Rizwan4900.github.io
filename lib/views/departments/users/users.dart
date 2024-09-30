import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/views/departments/users/payouts.dart';
import 'package:sasrecords/views/departments/users/staff_page.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool staff = true;
  int selectedPage = 0;
  
 final List<Widget> pages = [const StaffPage(), const Payouts()];
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
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedPage =0;
                              staff = true;
                            });
                          },
                          child: Container(
                            width: width * 0.1,
                            height: height * 0.09,
                            decoration: BoxDecoration(
                                color: selectedPage == 0
                                    ? AppColors.redButton
                                    : AppColors.textfieldColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Staff',
                                style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: selectedPage ==0? AppColors.textfieldColor: null),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              staff = false;
                              selectedPage=1;
    
                            });
                          },
                          child: Container(
                            width: width * 0.1,
                            height: height * 0.09,
                            decoration: BoxDecoration(
                                color: selectedPage == 1
                                    ? AppColors.redButton
                                    : AppColors.textfieldColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Payouts',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: selectedPage ==1? AppColors.textfieldColor : null
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: staff? const StaffPage(): const Payouts(),
                    )
                    
                    
                     
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
