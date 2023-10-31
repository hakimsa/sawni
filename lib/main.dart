import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'router/Router.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kim apps',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: getrouteAppliaction(),
      initialRoute: "/",
    );
  }
}
