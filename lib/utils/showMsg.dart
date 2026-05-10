import 'package:flutter/material.dart';

import '../main.dart';

//show success snack bar msg
  void showSuccessMsg(String? msg){

    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(msg!),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.green,
    ));
  }

//show failure snack bar msg

  void showFailureMsg(String? msg){

    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(msg!),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ));
  }