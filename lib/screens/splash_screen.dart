import 'package:currency_converter/api/api_client.dart';
import 'package:currency_converter/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiClient _api = ApiClient();
  List<String> currencies;
  String from;
  String to;

  @override
  void initState() {
    super.initState();
    getCurrencyList();
  }

  getCurrencyList() async {
    List<String> list = await _api.getCurrencies();
    setState(() {
      currencies = list;
      from = list[0];
      to = list[1];
    });

    Navigator.pushNamed(
      context,
      CurrencyRoutes.homepage,
      arguments: {'currencies': currencies, 'from': from, 'to': to},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
