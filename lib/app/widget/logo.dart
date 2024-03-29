import 'package:flutter/material.dart';
import '../services/screenAdapter.dart';
import '../services/ityingFonts.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: ScreenAdapter.width(40)),
              child: const Icon(
                ItyingFonts.xiaomi,
                size: 80,
                color: Color.fromARGB(255, 216, 57, 57),
              ),
            );
  }
}