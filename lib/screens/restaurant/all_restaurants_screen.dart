import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/providers/restaurant_provider.dart';
import 'package:food_delivery/widgets/restaurant_card.dart';

class AllRestaurantsScreen extends StatelessWidget {
  const AllRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants = context.watch<RestaurantProvider>().restaurants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Restaurants'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return RestaurantCard(
            name: restaurant['name'],
            image: restaurant['image'],
            rating: restaurant['rating'],
            deliveryTime: restaurant['deliveryTime'],
            deliveryFee: restaurant['deliveryFee'],
            cuisine: restaurant['cuisine'],
          );
        },
      ),
    );
  }
} 