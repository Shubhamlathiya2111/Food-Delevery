import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '1',
      'restaurantName': 'Burger King',
      'items': [
        {
          'name': 'Chicken Burger',
          'quantity': 2,
          'price': 9.99,
        },
        {
          'name': 'French Fries',
          'quantity': 1,
          'price': 4.99,
        }
      ],
      'total': 24.97,
      'status': 'Delivered',
      'date': '2024-03-15',
      'orderNumber': 'OD001',
    },
    {
      'id': '2',
      'restaurantName': 'Pizza Paradise',
      'items': [
        {
          'name': 'Pepperoni Pizza',
          'quantity': 1,
          'price': 14.99,
        }
      ],
      'total': 14.99,
      'status': 'In Progress',
      'date': '2024-03-16',
      'orderNumber': 'OD002',
    },
    // Add more orders as needed
  ];

  List<Map<String, dynamic>> get orders => _orders;
} 