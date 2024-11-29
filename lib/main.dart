import 'package:flutter/material.dart';
import 'package:food_delivery/providers/auth_provider.dart';
import 'package:food_delivery/providers/restaurant_provider.dart';
import 'package:food_delivery/providers/category_provider.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/providers/order_provider.dart';
import 'package:food_delivery/screens/splash_screen.dart';
import 'package:food_delivery/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    @override
ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.red), // Green background color
      foregroundColor: MaterialStateProperty.all(Colors.white), // White text color
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 20, // Larger font size
          fontWeight: FontWeight.bold, // Bold text
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Padding for larger button size
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
    ),
  );
}



    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Food Delivery App',
        theme: ThemeData(
          appBarTheme: AppBarTheme.of(context),
          elevatedButtonTheme: elevatedButtonTheme(),
        ),
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
