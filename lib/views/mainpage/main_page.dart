import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/constants/app_colors.dart';
import 'package:sasrecords/providers/page_provider.dart';
import 'package:sasrecords/views/departments/buff_unit.dart';
import 'package:sasrecords/views/departments/cutting_unit.dart';
import 'package:sasrecords/views/departments/drum_unit.dart';
import 'package:sasrecords/views/departments/purchase_data.dart';
import 'package:sasrecords/views/departments/purchase_page.dart';
import 'package:sasrecords/views/departments/ready_stocks.dart';
import 'package:sasrecords/views/departments/shaver_unit.dart';
import 'package:sasrecords/views/departments/split_unit.dart';
import 'package:sasrecords/views/departments/stitching_unit.dart';
import 'package:sasrecords/views/departments/store/store_page.dart';
import 'package:sasrecords/views/departments/users/users.dart';
import 'package:sasrecords/views/mainpage/widgets/dashboard.dart';
import 'package:sasrecords/views/mainpage/widgets/sidebar.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 // int _selectedIndex = 0;

  // Pages to switch between
  final List<Widget> _pages = [
    const Dashboard(),
    const StorePage(),
    const ReadyStocks(),
    const Users(),
    const PurchasePage(),
    const StorePage(),
    const Users(),
    const DrumUnit(),
    const ShaverUnit(),
    const BuffUnit(),
    const PurchaseData(),
    const CuttingUnit(),
    const StitchingUnit(),
    const SplitUnit()
  ];

  // void _onItemSelected(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PageProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:  Row(children: [
          const Expanded(child: SizedBox(child: Sidebar())),
        Expanded(
          flex: 4,
          child: IndexedStack(
              index: provider.selectedIndex,
              children: _pages,
            ),)
      ],),
    );
  }
}
