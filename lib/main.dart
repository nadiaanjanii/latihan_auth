import 'package:flutter/material.dart';
import 'package:latihan_authentication/pages/home_page.dart';

import 'package:provider/provider.dart';
import './pages/auth_page.dart';
import './providers/products.dart';
import './providers/auth.dart';
import './pages/add_product_page.dart';
import './pages/edit_product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Products>(
            create: (context) => Products(),
            update: (context, auth, products) =>
                products!..updateData(auth.token))
      ],
      builder: (context, child) => Consumer<AuthProvider>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuthProvider ? HomePage() : LoginPage(),
          routes: {
            AddProductPage.route: (ctx) => AddProductPage(),
            EditProductPage.route: (ctx) => EditProductPage(),
          },
        ),
      ),
    );
  }
}
