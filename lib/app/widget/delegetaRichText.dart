import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../services/screenAdapter.dart';

class DelegateRichText extends StatefulWidget {
  final void Function(bool)? chooseChange;
  DelegateRichText({super.key, this.chooseChange});

  @override
  State<DelegateRichText> createState() => _DelegateRichTextState();
}

class _DelegateRichTextState extends State<DelegateRichText> {
  late TapGestureRecognizer _tapUser;
  late TapGestureRecognizer _tapServer;
  late TapGestureRecognizer _tapPolicy;
  late  bool _ischoose; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ischoose = true;

    _tapUser = TapGestureRecognizer()
      ..onTap = () {
        print('点击 用户条款');
      };

    _tapServer = TapGestureRecognizer()
      ..onTap = () {
        print('点击 服务条款');
      };

    _tapPolicy = TapGestureRecognizer()
      ..onTap = () {
        print('点击 隐私政策');
      };
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _tapUser.dispose();
    _tapPolicy.dispose();
    _tapServer.dispose();
    print("---手势销毁");

    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    
    return Container(
        margin: EdgeInsets.only(top: ScreenAdapter.width(80)),
        child: Row(
          children: [
            Checkbox(value: _ischoose, onChanged: (v) {
              setState(() {
                _ischoose = !_ischoose;
              });
              
              print("--------- $v");
              widget.chooseChange;
              
            }),
            Expanded(
                child: Container(
              child: RichText(
                  text: TextSpan(
                      text: "已阅读并同意",
                      style: TextStyle(color: Colors.black87),
                      children: [
                    TextSpan(
                        text: "《商城用户协议》",
                        style: TextStyle(color: Colors.orange),
                        recognizer: _tapUser),
                    TextSpan(
                        text: "《隐私协议》",
                        style: TextStyle(color: Colors.orange),
                        recognizer: _tapPolicy),
                    TextSpan(
                        text: "《商城服务协议》",
                        style: TextStyle(color: Colors.orange),
                        recognizer: _tapServer),
                  ])),
            ))
          ],
        ));
  }
}
