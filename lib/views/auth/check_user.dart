import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sasrecords/views/auth/login_page.dart';
import 'package:sasrecords/views/mainpage/main_page.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  bool _loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    checkUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loggedIn?
      MainPage() : 
      LoginPage()
      ,
    );
  }

  checkUser(){
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  if (user!=null) {
   _loggedIn = true;
  } else {
    _loggedIn = false;
  }
}
}