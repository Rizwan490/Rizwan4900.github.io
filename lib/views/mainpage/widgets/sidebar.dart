import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/providers/page_provider.dart';
import 'package:sasrecords/views/auth/login_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key,});
// final int selectedIndex;
// final ValueChanged<int> onItemSelected;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PageProvider>(context);
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(children: [
        const SizedBox(height: 40,),
        Divider( color: Colors.grey.withOpacity(0.2),),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Image.asset('assets/images/mylogo.png'),
          ),
        ),
        Divider( color: Colors.grey.withOpacity(0.2),),
        //SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Container(decoration: BoxDecoration(color: AppColors.textfieldColor, borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.person, size: 50,)
              ),
              const SizedBox(width: 10,),
              Text("Ahmad", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textfieldColor),),
            ],
          ),
        ),
        Divider( color: Colors.grey.withOpacity(0.2),),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10,),
           child: Column(children: [
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: provider.selectedIndex ==0 ? Colors.grey : null,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                leading: Image.asset('assets/icons/layer3.png', width: 20,),
                title: Text("Departments", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textfieldColor),),
                selected: provider.selectedIndex == 0,
              selectedTileColor: Colors.blueGrey,
              onTap: () {
                provider.selecteIndex(0); // Notify parent that Dashboard is selected
              },
                ),
            ),
            
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                color: provider.selectedIndex ==1 ? Colors.grey : null,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                leading: Image.asset('assets/icons/layer4.png', width: 20,),
                title: Text("Store", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textfieldColor),),
                selected: provider.selectedIndex == 1,
              selectedTileColor: Colors.blueGrey,
              onTap: () {
                provider.selecteIndex(1);// Notify parent that Dashboard is selected
              },
                ),
            ),
           
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                color: provider.selectedIndex ==2 ? Colors.grey : null,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                leading: Image.asset('assets/icons/layer5.png', width: 20,),
                title: Text("Ready Stock", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textfieldColor),),
                selected: provider.selectedIndex == 2,
              selectedTileColor: Colors.blueGrey,
              onTap: () {
                provider.selecteIndex(2); // Notify parent that Dashboard is selected
              },
                ),
            ),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                color: provider.selectedIndex ==3 ? Colors.grey : null,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                leading: Image.asset('assets/icons/layer6.png', width: 20,),
                title: Text("Users", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textfieldColor),),
                selected: provider.selectedIndex == 3,
              selectedTileColor: Colors.blueGrey,
              onTap: () {
                provider.selecteIndex(3); // Notify parent that Dashboard is selected
              },
                ),
            ),

            const SizedBox(height: 30,),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.redButton,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Logout', style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500),),),
              ),
            )
                   ],),
         )
      ],),
    );
  }
}
