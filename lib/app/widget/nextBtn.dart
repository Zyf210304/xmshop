import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';

class NextBtn extends StatelessWidget {

  final String hintText;
  final void Function()? onTap;
  final double margin_h;

  const NextBtn({super.key, required this.hintText, this.onTap, this.margin_h = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
              
              margin: EdgeInsets.fromLTRB(margin_h, ScreenAdapter.height(80), margin_h, 0),
              height: ScreenAdapter.height(130),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: onTap, child: Text(hintText, style: TextStyle(fontSize: ScreenAdapter.fontSize(45)),)),
            );
  }
}