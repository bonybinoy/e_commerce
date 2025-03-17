import 'package:e_commerce/screens/login_page.dart';
import 'package:e_commerce/screens/splash_screen.dart';
import 'package:e_commerce/models/wish_list_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/cart_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register the Hive adapters only if they are not already registered
  if (!Hive.isAdapterRegistered(CartModelAdapter().typeId)) {
    Hive.registerAdapter(CartModelAdapter());
  }
  if (!Hive.isAdapterRegistered(WishListModelAdapter().typeId)) {
    Hive.registerAdapter(WishListModelAdapter());
  }

  try {
    // Open the boxes for CartModel and WishListModel
    await Hive.openBox<CartModel>('cart');
    await Hive.openBox<WishListModel>('WishList');
  } catch (e) {
    print('Error opening Hive boxes: $e');
    // You can show an error dialog or navigate to an error screen here
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luxecart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
