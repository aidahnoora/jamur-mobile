import 'dart:js';

import 'package:flutter/material.dart';
import 'package:jamur/models/product_model.dart';
import 'package:jamur/providers/wishlist_provider.dart';
import 'package:jamur/theme.dart';
import 'package:provider/provider.dart';

class WishListCard extends StatelessWidget {

  final ProductModel product;
  WishListCard(this.product);

  @override
  Widget build(BuildContext context) {
    
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 20,),
      padding: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/image_jamur.jpeg',
              width: 60,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  product.name!,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Rp ${product.price}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(product);
            },
            child: Image.asset(
              'assets/button_wishlist_blue.png',
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}