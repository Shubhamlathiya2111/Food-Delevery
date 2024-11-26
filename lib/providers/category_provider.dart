import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  String? _selectedCategory;
  
  String? get selectedCategory => _selectedCategory;

  final List<Map<String, dynamic>> categories = [
    {
      'id': '1',
      'title': 'South Indian',
      'icon': Icons.restaurant_menu,
      'color': Colors.orange,
    },
    {
      'id': '2',
      'title': 'North Indian',
      'icon': Icons.dinner_dining,
      'color': Colors.red,
    },
    {
      'id': '3',
      'title': 'Chinese',
      'icon': Icons.ramen_dining,
      'color': Colors.green,
    },
    {
      'id': '4',
      'title': 'Thali',
      'icon': Icons.rice_bowl,
      'color': Colors.purple,
    },
    {
      'id': '5',
      'title': 'Snacks',
      'icon': Icons.lunch_dining,
      'color': Colors.brown,
    },
  ];

  void selectCategory(String? categoryTitle) {
    _selectedCategory = categoryTitle;
    notifyListeners();
  }
} 