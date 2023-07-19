import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipix_mt/View/loginPage/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


@override
  void initState() {
     Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()
                )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: splashScreenBody(),
    );
  }

  splashScreenBody() {
    final Size size = MediaQuery.of(context).size;
    return  SafeArea(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container
        (
          height: size.height,
        width: size.width,
        child: Center(
          child:Container(
            child: Image.asset("assets/images/splash_logo.png"),
          ) ,
        ),
        ),
      ),
    );
  }
}
