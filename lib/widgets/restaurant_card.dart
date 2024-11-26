import 'package:flutter/material.dart';
import 'package:food_delivery/screens/restaurant/restaurant_details_screen.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String image;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final String cuisine;
  final VoidCallback? onSeeAllPressed;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.cuisine,
    this.onSeeAllPressed,
  });

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return Colors.green;
    if (rating >= 4.0) return Colors.lightGreen;
    if (rating >= 3.5) return Colors.orange;
    if (rating >= 3.0) return Colors.orangeAccent;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsScreen(
              restaurant: {
                'name': name,
                'image': image,
                'rating': rating,
                'deliveryTime': deliveryTime,
                'deliveryFee': deliveryFee,
                'cuisine': cuisine,
                'menu': [
                  {
                    'name': 'Masala Dosa',
                    'description': 'Crispy rice crepe with potato filling',
                    'price': 8.99,
                    'image': 'https://example.com/masala-dosa.jpg',
                    'isPopular': true,
                    'isVeg': true,
                  },
                  {
                    'name': 'Paneer Butter Masala',
                    'description': 'Cottage cheese in rich tomato gravy',
                    'price': 12.99,
                    'image': 'https://example.com/paneer.jpg',
                    'isPopular': true,
                    'isVeg': true,
                  },
                  // Add more menu items
                ],
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getRatingColor(rating),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cuisine,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(deliveryTime),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.delivery_dining,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(deliveryFee),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 