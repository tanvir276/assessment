import 'package:assessment/common/splash_screen.dart';
import 'package:assessment/core/navigation/route_name.dart';
import 'package:assessment/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:assessment/features/sign_up/presentation/screen/sign_up.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class RouteConfig {
  Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.initialRoute:
        return _getInitialRoute();
      case RouteName.signInRoute:
        return _getSignInRoute();
      case RouteName.signUpRoute:
        return _getSignUpRoute();
    }
    return _defaultRoute();
  }

  static MaterialPageRoute _routeBuilder(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  static MaterialPageRoute _defaultRoute() {
    return _routeBuilder(
      const Scaffold(
        body: Center(
          child: Text('Unknown route'),
        ),
      ),
    );
  }

  static MaterialPageRoute _getInitialRoute() {
    return _routeBuilder(const SplashScreen());
  }

  static MaterialPageRoute _getSignInRoute() {
    return _routeBuilder(const SignIn());
  }

  static MaterialPageRoute _getSignUpRoute() {
    return _routeBuilder(const SignUp());
  }
}
