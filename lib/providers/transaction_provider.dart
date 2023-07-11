import 'package:flutter/material.dart';
import 'package:jamur/models/cart_model.dart';
import 'package:jamur/services/transaction_service.dart';
import 'package:universal_io/io.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      File image) async {
    try {
      print('jalan provider');
      if (await TransactionService()
          .checkout(token, carts, totalPrice, image)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool> checkoutWeb(String token, List<CartModel> carts,
      double totalPrice, String base64img) async {
    try {
      print('jalan provider');
      if (await TransactionService()
          .checkoutWeb(token, carts, totalPrice, base64img)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }
}
