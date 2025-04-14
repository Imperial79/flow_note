import 'package:flow_note/Resources/constants.dart';
import 'package:flutter/material.dart';

class Splash_UI extends StatelessWidget {
  const Splash_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Image.asset("$kImagePath/logo.png"))),
    );
  }
}
