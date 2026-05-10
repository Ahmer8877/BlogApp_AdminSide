import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Data/Admin_provider/AdminAuth_provider.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {


  @override
  Widget build(BuildContext context) {

    //scaffold is main root of screen
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;

          // set constraints of customize screen with separate widget
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isMobile
                  ? SingleChildScrollView(
                child: Column(
                  children: [
                    //loginForm in separate widget

                    loginForm(context),
                    const SizedBox(height: 25),

                    // casual image separate widget
                    rightImage(),
                  ],
                ),
              )
                  : Row(
                children: [
                  // loginForm widget
                  Expanded(child: loginForm(context)),
                 // casual image separate widget
              Expanded(child: rightImage()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final email=TextEditingController();
final password=TextEditingController();
final formKey=GlobalKey<FormState>();


// ================= LEFT FORM =================

Widget loginForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome Back!!",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 30),

          // EMAIL
          inputField(
            hint: "email@gmail.com",
            icon: Icons.email_outlined,
            controller: email,
            msg: 'please enter email',
          ),

          const SizedBox(height: 20),

          // PASSWORD
          inputField(
            hint: "Enter your password",
            icon: Icons.lock_outline,
            isPassword: true,
            controller: password,
            msg: 'please enter password',
          ),

          const SizedBox(height: 25),

          // LOGIN BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: Consumer<AdminAuthProvider>(
                builder: (context,provider,child) {
                  return provider.isLoading? Center(child: CircularProgressIndicator(),) : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDDBEA9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        provider.adminLogin(email.text.trim(), password.text.trim(), context);
                        email.clear();
                        password.clear();
                      }

                    },
                    child: const Text(
                      "Admin Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    ),
  );
}

// ================= INPUT FIELD =================
Widget inputField({
  required String hint,
  required IconData icon,
  bool isPassword = false,
  required TextEditingController controller,
  required String msg
}) {
  return TextFormField(
    validator: (value){
      if(value==null || value.isEmpty){
        return msg;
      }
      return null;

    },
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

// ================= RIGHT IMAGE =================
Widget rightImage() {
  return Padding(
    padding: const EdgeInsets.all(40),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // BACKGROUND SHAPE
        Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFDDBEA9),
            borderRadius: BorderRadius.circular(150),
          ),
        ),

        // IMAGE (ASSET)
        Image.asset(
          "assets/images/login.jpg",
          height: 300,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}