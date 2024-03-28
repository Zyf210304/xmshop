import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class PassTextField extends StatelessWidget {

  final String hintText;
  final void Function(String)? onChanged;
  TextInputType inputType;

  PassTextField({super.key, required this.hintText, this.onChanged, this.inputType = TextInputType.phone});


  @override
  Widget build(BuildContext context) {
   

    return Container(
        alignment: Alignment.center,
        height: ScreenAdapter.height(160),
        margin: EdgeInsets.only(top: ScreenAdapter.height(100)),
        padding: EdgeInsets.only(left: ScreenAdapter.width(40)),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 250, 243, 242),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: TextField(
          onChanged: onChanged,
          keyboardType: inputType,
          style: TextStyle(fontSize: ScreenAdapter.fontSize(48)),
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(0),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ));
  }
}

