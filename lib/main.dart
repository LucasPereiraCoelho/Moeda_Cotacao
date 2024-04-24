import 'package:flutter/material.dart';
import 'package:flutter_application_7/views/home_page.dart';
import 'package:flutter_application_7/views/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(),
    home: Login(),
  ));
}
