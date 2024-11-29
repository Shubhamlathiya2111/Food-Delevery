import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/screens/cart/cart_screen.dart';
import 'package:provider/provider.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
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
    // Updated menu items with vegetarian options
    final List<Map<String, dynamic>> menuItems = [
      {
        'name': 'Paneer Tikka',
        'description': 'Grilled cottage cheese marinated in Indian spices',
        'price': 12.99,
        'image': 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8',
        'isPopular': true,
        'isVeg': true,
      },
      {
        'name': 'Veg Supreme Pizza',
        'description': 'Fresh vegetables on a crispy base with special sauce',
        'price': 14.99,
        'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
        'isPopular': true,
        'isVeg': true,
      },
      {
        'name': 'Mushroom Burger',
        'description': 'Grilled mushroom patty with fresh veggies',
        'price': 9.99,
        'image': 'https://images.unsplash.com/photo-1585238342024-78d387f4a707',
        'isPopular': false,
        'isVeg': true,
      },
      {
        'name': 'Dal Makhani',
        'description': 'Creamy black lentils cooked overnight',
        'price': 11.99,
        'image': 'https://images.unsplash.com/photo-1546833999-b9f581a1996d',
        'isPopular': true,
        'isVeg': true,
      }
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                restaurant['image'],
                fit: BoxFit.cover,
              ),
              title: Text(
                restaurant['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          actions: [IconButton(
                icon: const Icon(Icons.shopping_cart,color: Colors.white,),
                onPressed: () {
                  // Navigate to cart screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant Info Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant['cuisine'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getRatingColor(restaurant['rating']),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            restaurant['rating'].toString(),
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
                                    const SizedBox(width: 8),
                                    Text(
                                      '(128 reviews)',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(restaurant['deliveryTime']),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.delivery_dining,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(restaurant['deliveryFee']),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 32),

                      // Menu Section
                      const Text(
                        'Popular Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['image'],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.error),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item['name'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (item['isPopular'])
                                              Container(
                                                margin: const EdgeInsets.only(left: 8),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: const Text(
                                                  'Popular',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['description'],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${item['price']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                                                final isInCart = cartProvider.isItemInCart(item['name']);
                                                
                                                if (isInCart) {
                                                  cartProvider.removeItem(item['name']);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('${item['name']} removed from cart'),
                                                      duration: const Duration(seconds: 1),
                                                    ),
                                                  );
                                                } else {
                                                  cartProvider.addItem({
                                                    'name': item['name'],
                                                    'price': item['price'],
                                                    'image': item['image'],
                                                    'restaurantName': restaurant['name'],
                                                  });
                                                  
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('${item['name']} added to cart'),
                                                      duration: const Duration(seconds: 1),
                                                    ),
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Provider.of<CartProvider>(context).isItemInCart(item['name'])
                                                    ? Colors.red
                                                    : Theme.of(context).primaryColor,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Provider.of<CartProvider>(context).isItemInCart(item['name'])
                                                        ? Icons.remove_shopping_cart
                                                        : Icons.add_shopping_cart,
                                                        color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    Provider.of<CartProvider>(context).isItemInCart(item['name'])
                                                        ? 'Remove'
                                                        : 'Add to Cart',
                                                        style: const TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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