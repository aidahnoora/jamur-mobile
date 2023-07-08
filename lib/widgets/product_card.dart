import 'package:flutter/material.dart';
import 'package:jamur/models/product_model.dart';
import 'package:jamur/pages/product_page.dart';
import 'package:jamur/theme.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;

  ProductCard(
    this.product
  );

  @override
  Widget build(BuildContext context) {
  
  String baseurl = 'http://192.168.0.107:8000';
  String url = product.galleries![0].url;
  String result = url.replaceAll('http://localhost', '');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product),
          ),
        );
      },
      child: Container(
        width: 215,
        height: 278,
        margin: EdgeInsets.only(
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffECEDEF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            // Image.asset(
            //   'assets/image_jamur.jpeg',
            //   width: 215,
            //   height: 150,
            //   fit: BoxFit.cover,
            // ),
            Image.network(
              '${baseurl}${result}',
              // product.galleries![0].url,
              // 'https://picsum.photos/250?image=9',
              width: 215,
              height: 150,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6,),
                  Text(
                    product.category!.name,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    product.name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    'Rp ${product.price}',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}