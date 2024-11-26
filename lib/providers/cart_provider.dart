import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get total => _items.fold(
        0,
        (sum, item) => sum + (item['price'] * item['quantity']),
      );

  int get itemCount => _items.length;

  bool isItemInCart(String itemName) {
    return _items.any((item) => item['name'] == itemName);
  }

  void addItem(Map<String, dynamic> item) {
    final existingIndex = _items.indexWhere((i) => i['name'] == item['name']);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity']++;
    } else {
      _items.add({...item, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(String itemName) {
    _items.removeWhere((item) => item['name'] == itemName);
    notifyListeners();
  }

  void updateQuantity(String itemName, int quantity) {
    final index = _items.indexWhere((item) => item['name'] == itemName);
    if (index != -1) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index]['quantity'] = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
} 