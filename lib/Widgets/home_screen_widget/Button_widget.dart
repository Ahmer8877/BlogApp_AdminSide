import 'package:flutter/material.dart';


//status Button separate widget

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Function onTap;

  const ButtonWidget({super.key, required this.text, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return
      //status section

      InkWell(
        onTap: (){
          onTap();
        },
        child: Container(
          constraints: BoxConstraints(
              maxHeight: 30,
              maxWidth: 90
          ),
          height: 30,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:color,
              shape: BoxShape.rectangle
          ),
          child: Text(text.toUpperCase()),
        ),
      );
  }
}
