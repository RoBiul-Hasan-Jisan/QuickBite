import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // navigateToScreens(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home', // Changed from 'title' to 'label'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.near_me),
          label: 'Near By', // Changed from 'title' to 'label'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Cart', // Changed from 'title' to 'label'
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Account', // Changed from 'title' to 'label'
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFFfd5352),
      unselectedItemColor: const Color(0xFF2c2b2b), // Added unselected color
      onTap: _onItemTapped,
    );
  }
}