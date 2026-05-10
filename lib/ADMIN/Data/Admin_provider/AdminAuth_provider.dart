import 'package:blog_admin_side/ADMIN/Admin_screens/Admin_Auth_Screen/Login_Screen/AdminLogin_screen.dart';
import 'package:blog_admin_side/ADMIN/Admin_screens/Home_screen/Home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/showMsg.dart';

class AdminAuthProvider with ChangeNotifier{

  //initialize FirebaseAuth
  FirebaseAuth auth=FirebaseAuth.instance;
  //initialize FirebaseFirestore
  FirebaseFirestore db =FirebaseFirestore.instance;
  //variable use for loding
  bool isLoading=false;


  //admin login Function

  Future<void> adminLogin(String email,String password,BuildContext context)async{

    try{
      isLoading=true;
      safeNotify();
      final result=await auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      final user=await db.collection('BlogUsers').doc(result.user?.uid).get();
      if(user.data()!['role']=='admin'){
        if(context.mounted){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>AdminHomeScreen()), (value)=>false);

        }
      }else{
        await auth.signOut();
        showFailureMsg('You are not Admin ');
      }
      showSuccessMsg('Admin Login Successful');

    }on FirebaseAuthException catch(f){
      showFailureMsg(f.toString());
    }catch(e){
      showFailureMsg(e.toString());
    }finally{
      isLoading=false;
      safeNotify();
    }
  }

  //admin signOut function

  Future<void> signOut(BuildContext context)async{

    try{
      isLoading=true;
      safeNotify();
      await auth.signOut();

      if(context.mounted){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> AdminLoginScreen()), (value)=>false);
      }
    }on FirebaseAuthException catch(e){
      showFailureMsg(e.toString());
    }catch(f){
      showFailureMsg(f.toString());
    }finally{
      isLoading=false;
      safeNotify();
    }
  }

  //safe notifyListeners function

  void safeNotify() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}