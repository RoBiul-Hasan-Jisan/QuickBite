import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_delivery/animation/ScaleRoute.dart';
import 'package:flutter_food_delivery/pages/SignInPage.dart';
import 'package:flutter_food_delivery/widgets/BestFoodWidget.dart';
import 'package:flutter_food_delivery/widgets/BottomNavBarWidget.dart';
import 'package:flutter_food_delivery/widgets/PopularFoodsWidget.dart';
import 'package:flutter_food_delivery/widgets/SearchWidget.dart';
import 'package:flutter_food_delivery/widgets/TopMenus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        title: const Text(
          "What would you like to eat?",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light, // Fixed brightness
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF3a3737),
            ),
            onPressed: () {
              Navigator.push(context, ScaleRoute(page: const SignInPage()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            SearchWidget(),
            TopMenus(),
            PopularFoodsWidget(),
            BestFoodWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}