import 'package:currency_converter/routes/routes.dart';
import 'package:currency_converter/screens/home_page.dart';
import 'package:currency_converter/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class CurrencyRouter {
  static Route<dynamic> generateRoute(RouteSettings routesettings) {
    switch (routesettings.name) {
      case CurrencyRoutes.homepage:
        Map<String, dynamic> params =
            routesettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => HomePage(
                  currencies: params['currencies'],
                  from: params['from'],
                  to: params['to'],
                ));
      case CurrencyRoutes.splashscreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
