import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assessment/core/utils/lang/size_config.dart';
import 'package:assessment/demo/screen/demo.dart';
import 'package:assessment/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? accessToken;
  getSignInResponse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    super.initState();
    getSignInResponse();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: double.infinity,
        duration: 1000,
        splash: Icon(
          size: 100,
          Icons.assignment,
          weight: double.infinity,
        ),
        nextScreen: accessToken == null ? SignIn() : const SignIn(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xffCDF2FB),
      ),
    );
  }
}
