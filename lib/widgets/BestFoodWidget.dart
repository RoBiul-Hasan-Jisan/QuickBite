import 'package:flutter/material.dart';

class BestFoodWidget extends StatefulWidget {
  const BestFoodWidget({Key? key}) : super(key: key);

  @override
  _BestFoodWidgetState createState() => _BestFoodWidgetState();
}

class _BestFoodWidgetState extends State<BestFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const BestFoodTitle(),
          Expanded(
            child: BestFoodList(),
          )
        ],
      ),
    );
  }
}

class BestFoodTitle extends StatelessWidget {
  const BestFoodTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Best Foods",
            style: TextStyle(
                fontSize: 20,
                color: const Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class BestFoodTiles extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rating;
  final String numberOfRating;
  final String price;
  final String slug;

  const BestFoodTiles({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.numberOfRating,
    required this.price,
    required this.slug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: const BoxDecoration(boxShadow: [
              /* BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),*/
            ]),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                'assets/images/bestfood/' + imageUrl + ".jpeg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              margin: const EdgeInsets.all(5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber[700],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '($numberOfRating ratings)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3a3a3b),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BestFoodList extends StatelessWidget {
  BestFoodList({Key? key}) : super(key: key);

  final List<Map<String, String>> foodItems = [
    {
      'name': "Fried Egg",
      'imageUrl': "ic_best_food_8",
      'rating': '4.9',
      'numberOfRating': '200',
      'price': '15.06',
      'slug': "fried_egg"
    },
    {
      'name': "Mixed vegetable",
      'imageUrl': "ic_best_food_9",
      'rating': "4.9",
      'numberOfRating': "100",
      'price': "17.03",
      'slug': ""
    },
    {
      'name': "Salad with chicken meat",
      'imageUrl': "ic_best_food_10",
      'rating': "4.0",
      'numberOfRating': "50",
      'price': "11.00",
      'slug': ""
    },
    {
      'name': "New mixed salad",
      'imageUrl': "ic_best_food_5",
      'rating': "4.00",
      'numberOfRating': "100",
      'price': "11.10",
      'slug': ""
    },
    {
      'name': "Red meat with salad",
      'imageUrl': "ic_best_food_1",
      'rating': "4.6",
      'numberOfRating': "150",
      'price': "12.00",
      'slug': ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final item = foodItems[index];
        return BestFoodTiles(
          name: item['name']!,
          imageUrl: item['imageUrl']!,
          rating: item['rating']!,
          numberOfRating: item['numberOfRating']!,
          price: item['price']!,
          slug: item['slug']!,
        );
      },
    );
  }
}