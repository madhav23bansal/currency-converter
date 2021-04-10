import 'package:currency_converter/routes/router.dart';
import 'package:currency_converter/routes/routes.dart';
import 'package:currency_converter/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CurrencyRouter.generateRoute,
      initialRoute: CurrencyRoutes.splashscreen,
    );
  }
}
