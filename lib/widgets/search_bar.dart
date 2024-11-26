import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/providers/restaurant_provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light 
            ? Colors.grey[100] 
            : Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.brightness == Brightness.light 
              ? Colors.grey[300]! 
              : Colors.grey[700]!,
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(
          color: theme.brightness == Brightness.light 
              ? Colors.black87 
              : Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for restaurants or dishes',
          hintStyle: TextStyle(
            color: theme.brightness == Brightness.light 
                ? Colors.grey[600] 
                : Colors.grey[400],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: theme.brightness == Brightness.light 
                ? Colors.grey[600] 
                : Colors.grey[400],
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: theme.brightness == Brightness.light 
                        ? Colors.grey[600] 
                        : Colors.grey[400],
                  ),
                  onPressed: () {
                    _searchController.clear();
                    context.read<RestaurantProvider>().searchRestaurants('');
                  },
                )
              : null,
        ),
        onChanged: (value) {
          context.read<RestaurantProvider>().searchRestaurants(value);
        },
      ),
    );
  }
} 