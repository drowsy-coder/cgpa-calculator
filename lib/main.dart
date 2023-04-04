import 'package:cgpa/gpa.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GPA Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GPA(),
        debugShowCheckedModeBanner: false);
  }
}
