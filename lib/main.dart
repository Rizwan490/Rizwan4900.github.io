import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasrecords/controllers/auth_controller.dart';
import 'package:sasrecords/controllers/buff_controller.dart';
import 'package:sasrecords/controllers/cutting_controller.dart';
import 'package:sasrecords/controllers/drum_controller.dart';
import 'package:sasrecords/controllers/purchase_controller.dart';
import 'package:sasrecords/controllers/shaver_controller.dart';
import 'package:sasrecords/controllers/split_controller.dart';
import 'package:sasrecords/controllers/stitching_controller.dart';
import 'package:sasrecords/controllers/store_controller.dart';
import 'package:sasrecords/controllers/user_controller.dart';
import 'package:sasrecords/firebase_options.dart';
import 'package:sasrecords/providers/page_provider.dart';
import 'package:sasrecords/views/auth/check_user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthController(),),
      ChangeNotifierProvider(create: (context) => PurchaseController(),),
      ChangeNotifierProvider(create: (context) => PageProvider(),),
      ChangeNotifierProvider(create: (context) => StoreController(),),
      ChangeNotifierProvider(create: (context) => DrumController(),),
      ChangeNotifierProvider(create: (context) => BuffController(),),
      ChangeNotifierProvider(create: (context) => ShaverController(),),
      ChangeNotifierProvider(create: (context) => StitchingController(),),
      ChangeNotifierProvider(create: (context) => CuttingController(),),
      ChangeNotifierProvider(create: (context) => SplitController(),),
      ChangeNotifierProvider(create: (context) => UserController(),)
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sass Records',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CheckUser(),
    ),
    );
  }
}
