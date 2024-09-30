import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sasrecords/views/mainpage/main_page.dart';

class AuthController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference reference = FirebaseFirestore.instance.collection('users');
  bool _isLoading = false;
  bool get isLoading=> _isLoading;
  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  Future<void> userLogin(String email, String password, BuildContext context) async{
    setLoading(true);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(
                        backgroundColor: Colors.blueAccent,
                        content: Text("User Logged In")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(),));
setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                        backgroundColor: Colors.blueAccent,
                        content: Text(e.toString())));
    }
    notifyListeners();
  }

  logOutUser(){
    auth.signOut();
  }
  
}