import 'package:miniapps/login/sign_in.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: SignInPage(),
      duration: 3000,
      imageSrc:
          "http://www.barajacoding.or.id/wp-content/uploads/2021/02/flutter.png",
      backgroundColor: Colors.white,
    );
    ;
  }
}
