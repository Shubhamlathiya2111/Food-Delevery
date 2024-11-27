import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  List<dynamic> _orders = [];

  List<dynamic> get orders => _orders;

  void addOrder(dynamic order) {
    _orders.add(order);
    notifyListeners();
  }
} 