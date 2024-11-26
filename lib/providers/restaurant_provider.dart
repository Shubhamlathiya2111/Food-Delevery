import 'package:flutter/foundation.dart';

class RestaurantProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _restaurants = [
    {
      'id': '1',
      'name': 'South Indian Delight',
      'image': 'assets/images/restaurant_placeholder.png',
      'rating': 4.5,
      'deliveryTime': '20-30 min',
      'deliveryFee': '\$1.99',
      'cuisine': 'South Indian • Dosa • Idli',
      'category': 'South Indian',
    },
    {
      'id': '2',
      'name': 'Punjab Vegetarian',
      'image': 'assets/images/restaurant_placeholder.png',
      'rating': 4.8,
      'deliveryTime': '25-35 min',
      'deliveryFee': '\$2.99',
      'cuisine': 'North Indian • Curry • Naan',
      'category': 'North Indian',
    },
    {
      'id': '3',
      'name': 'Fresh & Healthy',
      'image': 'assets/images/restaurant_placeholder.png',
      'rating': 4.3,
      'deliveryTime': '15-25 min',
      'deliveryFee': '\$1.49',
      'cuisine': 'Salads • Smoothies • Bowls',
      'category': 'Healthy',
    },
    {
      'id': '4',
      'name': 'Vegan Delight',
      'image': 'assets/images/restaurant_placeholder.png',
      'rating': 4.6,
      'deliveryTime': '30-40 min',
      'deliveryFee': '\$2.49',
      'cuisine': 'Vegan • Plant-based • Organic',
      'category': 'Vegan',
    },
    {
      'id': '5',
      'name': 'Asian Veggie',
      'image': 'assets/images/restaurant_placeholder.png',
      'rating': 4.2,
      'deliveryTime': '25-35 min',
      'deliveryFee': '\$3.99',
      'cuisine': 'Chinese • Thai • Vegetarian',
      'category': 'Asian',
    },
  ];

  List<Map<String, dynamic>> _filteredRestaurants = [];
  String _searchQuery = '';
  String? _selectedCategory;

  List<Map<String, dynamic>> get restaurants {
    if (_searchQuery.isNotEmpty) {
      return _filteredRestaurants;
    }
    if (_selectedCategory != null) {
      return _restaurants.where((restaurant) => 
        restaurant['category'] == _selectedCategory
      ).toList();
    }
    return _restaurants;
  }

  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;

  void searchRestaurants(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredRestaurants = [];
    } else {
      _filteredRestaurants = _restaurants.where((restaurant) {
        final name = restaurant['name'].toString().toLowerCase();
        final cuisine = restaurant['cuisine'].toString().toLowerCase();
        return name.contains(_searchQuery) || cuisine.contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  void filterByCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchRestaurants() async {
    // In a real app, this would be an API call
    notifyListeners();
  }
} 