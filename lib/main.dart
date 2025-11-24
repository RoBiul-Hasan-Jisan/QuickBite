import 'package:flutter/material.dart';

// Use relative imports instead of package imports
import 'pages/FoodDetailsPage.dart';
import 'pages/FoodOrderPage.dart';
import 'pages/HomePage.dart';
import 'pages/SignInPage.dart';
import 'pages/SignUpPage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        hintColor: Color(0xFFd0cece),
      ),
      home: HomePage(),
    ));
