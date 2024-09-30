import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userType = TextEditingController();
Future<void> addUser() async{
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  try {
  final UserCredential credential =   await auth.createUserWithEmailAndPassword(email: 'admin@mail.com', password: 'admin123');
    User? user = credential.user;
    final uid = user!.uid;
   await ref.doc(uid).set({
      'userId':uid,
      'name':'Raza',
      'email':user.email,
      'userType':'admin'
    });
  } catch (e) {
    print(e.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          TextButton(onPressed: () {
            addUser();
          }, child: const Text("Add User", style: TextStyle(fontSize: 28),))
        ],),
      ),
    );
  }
}