import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/providers/restaurant_provider.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = context.watch<RestaurantProvider>();
    final isSelected = restaurantProvider.selectedCategory == title;

    return GestureDetector(
      onTap: () {
        restaurantProvider.filterByCategory(
          isSelected ? null : title
        );
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: isSelected ? color : color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: isSelected 
                    ? Border.all(color: color, width: 2)
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : color,
                size: 35,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? color : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 