import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jamur/models/product_model.dart';
import 'package:jamur/providers/cart_provider.dart';
import 'package:jamur/providers/wishlist_provider.dart';
import 'package:jamur/theme.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  
  final ProductModel product;
  ProductPage(this.product);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List images = [
    'assets/image_jamur.jpeg',
    'assets/image_jamur.jpeg',
    'assets/image_jamur.jpeg',
  ];

  final List familiarJamur = [
    'assets/image_jamur.jpeg',
    'assets/image_jamur.jpeg',
    'assets/image_jamur.jpeg',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    String baseurl = 'http://192.168.0.107:8000';

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (_) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Image.asset('assets/icon_success.png', width: 100),
                  const SizedBox(height: 12),
                  Text(
                    'Hore!',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Item berhasil ditambahkan',
                    style: secondaryTextStyle,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
        ),
      );
    }

    // Widget familiarJamurCard(String imageUrl) {
    //   return Container(
    //     width: 54,
    //     height: 54,
    //     margin: const EdgeInsets.only(
    //       right: 16,
    //     ),
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage(imageUrl),
    //       ),
    //       borderRadius: BorderRadius.circular(6),
    //     ),
    //   );
    // }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                  ),
                ),
                Icon(
                  Icons.shopping_bag,
                  color: backgroundColor1,
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: widget.product.galleries!
                .map((image) => Image.network(
                      '${baseurl}${image.url.replaceAll('http://localhost', '')}',
                      width: MediaQuery.of(context).size.width,
                      height: 310,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, _) {
                setState(() => currentIndex = index);
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries!.map((_) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget content() {
      // int index = -1;

      return Expanded(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 17,
          ),
          padding: EdgeInsets.only(
            top: defaultMargin,
            left: defaultMargin,
            right: defaultMargin,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            color: backgroundColor1,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //header
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name!,
                              style: primaryTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              widget.product.category!.name,
                              style: primaryTextStyle.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          wishlistProvider.setProduct(widget.product);

                          if (wishlistProvider.isWishlist(widget.product)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: secondaryColor,
                                content: const Text(
                                  'Berhasil ditambahkan ke wishlist',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: alertColor,
                                content: const Text(
                                  'Dihapus dari wishlist',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                          wishlistProvider.isWishlist(widget.product)
                              ? 'assets/button_wishlist_blue.png'
                              : 'assets/button_wishlist.png',
                          width: 46,
                        ),
                      ),
                    ],
                  ),
                ),
                //price
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 20,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: backgroundColor2,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Harga',
                        style: primaryTextStyle,
                      ),
                      Text(
                        'Rp ${widget.product.price}',
                        style: priceTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                //deskripsi
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: defaultMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deskripsi',
                        style: primaryTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.product.description!,
                        style: subtitleTextStyle.copyWith(
                          fontWeight: light,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                //familiar
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: defaultMargin,
                    bottom: defaultMargin,
                  ),
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Jamur Serupa',
                  //       style: primaryTextStyle.copyWith(
                  //         fontWeight: medium,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 12,
                  //     ),
                  //     SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         children: familiarJamur.map((image) {
                  //           return familiarJamurCard(image);
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
                //button
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(defaultMargin),
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/button_chat.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: TextButton(
                            onPressed: () {
                              cartProvider.addCart(widget.product);
                              showSuccessDialog();
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: primaryColor,
                            ),
                            child: Text(
                              'Tambah ke Keranjang',
                              style: primaryTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Widget customBottomNav() {
    //   return Container(
    //     padding: EdgeInsets.symmetric(
    //       horizontal: defaultMargin,
    //       vertical: 16,
    //     ),
    //     color: backgroundColor1,
    //     child: Row(
    //       children: [
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (_) => DetailChatPage(widget.product),
    //               ),
    //             );
    //           },
    //           child: Container(
    //             width: 54,
    //             height: 54,
    //             decoration: const BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage('assets/button_chat.png'),
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(width: 16),
    //         Expanded(
    //           child: SizedBox(
    //             width: 54,
    //             height: 54,
    //             child: TextButton(
    //               onPressed: () {
    //                 cartProvider.addCart(widget.product);
    //                 showSuccessDialog();
    //               },
    //               style: TextButton.styleFrom(
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(12),
    //                 ),
    //                 backgroundColor: primaryColor,
    //               ),
    //               child: Text(
    //                 'Tambah ke Keranjang',
    //                 style: primaryTextStyle.copyWith(
    //                   fontSize: 16,
    //                   fontWeight: semiBold,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          header(), 
          content(),
        ],
      ),
    );
  }
}
