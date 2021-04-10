import 'package:currency_converter/api/api_client.dart';
import 'package:currency_converter/common/drop_down_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String from;
  String to;
  List<String> currencies;

  HomePage({Key key, this.from, this.to, this.currencies}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance of ApiClient
  ApiClient _api = ApiClient();
  TextEditingController textValue = TextEditingController();

  Color mainColor = Color(0xFF212936);
  double rate;
  String resultRate = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  'Currency Converter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Column(
                children: [
                  TextField(
                    controller: textValue,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Enter Value to convert",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropDownButton(widget.currencies, widget.from, (val) {
                    setState(() {
                      widget.from = val;
                    });
                  }),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        String temp = widget.from;
                        setState(() {
                          widget.from = widget.to;
                          widget.to = temp;
                        });
                      });
                    },
                    child: Icon(Icons.swap_horiz_outlined),
                  ),
                  dropDownButton(widget.currencies, widget.to, (val) {
                    setState(() {
                      widget.to = val;
                    });
                  }),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (textValue.text == "") {
                      final snackBar = SnackBar(
                        content: Text("Value Can't be Empty"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      print(widget.from);
                      if (widget.from == null || widget.to == null) {
                        final snackBar = SnackBar(
                          content: Text(
                              "Please select the currency you want to convert"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        rate = await _api.getRate(widget.from, widget.to);
                        setState(() {
                          resultRate = (rate * double.parse(textValue.text))
                              .toStringAsFixed(3);
                        });
                      }
                    }
                  },
                  child: Text('Convert'),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Converted Value',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      resultRate.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
