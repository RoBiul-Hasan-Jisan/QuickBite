import 'package:flutter/material.dart';

class TopMenus extends StatefulWidget {
  const TopMenus({Key? key}) : super(key: key);

  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  int _selectedIndex = 0;

  final List<Map<String, String>> menuItems = [
    {"name": "Burger", "imageUrl": "ic_burger", "slug": ""},
    {"name": "Sushi", "imageUrl": "ic_sushi", "slug": ""},
    {"name": "Pizza", "imageUrl": "ic_pizza", "slug": ""},
    {"name": "Cake", "imageUrl": "ic_cake", "slug": ""},
    {"name": "Ice Cream", "imageUrl": "ic_ice_cream", "slug": ""},
    {"name": "Soft Drink", "imageUrl": "ic_soft_drink", "slug": ""},
    {"name": "Salad", "imageUrl": "ic_salad", "slug": ""},
    {"name": "Coffee", "imageUrl": "ic_coffee", "slug": ""},
  ];

  void _onMenuTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add your menu item tap functionality here
    print("Selected: ${menuItems[index]['name']}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return TopMenuTiles(
            name: item['name']!,
            imageUrl: item['imageUrl']!,
            slug: item['slug']!,
            isSelected: _selectedIndex == index,
            onTap: () => _onMenuTap(index),
          );
        },
      ),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String slug;
  final bool isSelected;
  final VoidCallback onTap;

  const TopMenuTiles({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.slug,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFfae3e2),
                  blurRadius: 25.0,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: Card(
              color: isSelected ? const Color(0xFFfb3132) : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Container(
                width: 50,
                height: 50,
                child: Center(
                  child: Image.asset(
                    'assets/images/topmenu/' + imageUrl + ".png",
                    width: 24,
                    height: 24,
                    color: isSelected ? Colors.white : const Color(0xFF6e6e71),
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.fastfood,
                        size: 24,
                        color: isSelected ? Colors.white : const Color(0xFF6e6e71),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: isSelected ? const Color(0xFFfb3132) : const Color(0xFF6e6e71),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}