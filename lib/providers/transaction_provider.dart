import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jamur/models/cart_model.dart';
import 'package:jamur/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(
    String token,
    List<CartModel> carts,
    double totalPrice,
    File image,
  ) async {
    try {
      if (await TransactionService().checkout(token, carts, totalPrice, image)) {
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
