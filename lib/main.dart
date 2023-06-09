// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jamur/pages/history_transaction_page.dart';
import 'package:jamur/providers/history_provider.dart';
import 'package:provider/provider.dart';
import 'package:jamur/pages/cart_page.dart';
import 'package:jamur/pages/checkout_page.dart';
import 'package:jamur/pages/checkout_success_page.dart';
import 'package:jamur/pages/edit_profile_page.dart';
import 'package:jamur/pages/home/main_page.dart';
import 'package:jamur/pages/sign_in_page.dart';
import 'package:jamur/pages/sign_up_page.dart';
import 'package:jamur/pages/splash_page.dart';
import 'package:jamur/providers/auth_provider.dart';
import 'package:jamur/providers/cart_provider.dart';
import 'package:jamur/providers/page_provider.dart';
import 'package:jamur/providers/product_provider.dart';
import 'package:jamur/providers/transaction_provider.dart';
import 'package:jamur/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const SplashPage(),
          '/sign-in': (_) => const SignInPage(),
          '/sign-up': (_) => const SignUpPage(),
          '/home': (_) => const MainPage(),
          '/edit-profile': (_) => const EditProfilePage(),
          '/cart': (_) => const CartPage(),
          '/checkout': (_) => const CheckoutPage(),
          '/checkout-success': (_) => const CheckoutSuccessPage(),
          '/history': (_) => const HistoryTransactionPage(),
        },
      ),
    );
  }
}