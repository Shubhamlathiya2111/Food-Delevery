import 'package:flutter/material.dart';
import 'package:food_delivery/providers/auth_provider.dart';
import 'package:food_delivery/providers/restaurant_provider.dart';
import 'package:food_delivery/providers/category_provider.dart';
import 'package:food_delivery/providers/cart_provider.dart';
import 'package:food_delivery/screens/splash_screen.dart';
import 'package:food_delivery/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/services/payment_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PaymentService.initPhonePe();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Food Delivery App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
