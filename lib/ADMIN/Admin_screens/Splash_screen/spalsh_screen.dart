import 'package:blog_admin_side/ADMIN/Admin_screens/Admin_Auth_Screen/Login_Screen/AdminLogin_screen.dart';
import 'package:blog_admin_side/ADMIN/Admin_screens/Home_screen/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //initialize FirebaseAuth
  FirebaseAuth auth=FirebaseAuth.instance;

  //initialize state
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){

      if(context.mounted){
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>auth.currentUser==null? AdminLoginScreen() : AdminHomeScreen()));

    }
    );
  }
  @override
  Widget build(BuildContext context) {

    //main root of screen

    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),

      //fake loading
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}
