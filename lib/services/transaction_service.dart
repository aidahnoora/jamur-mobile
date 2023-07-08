import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jamur/models/cart_model.dart';

import 'package:path/path.dart';

class TransactionService {
  String baseUrl = 'http://192.168.0.107:8000/api';

  Future<bool> checkout(
    String token,
    List<CartModel> carts,
    double totalPrice,
    File image,
  ) async {
    var url = '$baseUrl/checkout';
    var stream = http.ByteStream(Stream.castFrom(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse(url);
    
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": token,
    };

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile("image", stream, length,
        filename: basename(image.path));

    Map<String, String> body = {
      'address': 'Pacitan',
      'items': jsonEncode(carts
          .map((cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              })
          .toList()),
      'status': 'PENDING',
      'total_price': totalPrice.toString(),
      'shipping_price': 0.toString(),
    };

    print(body);
    request.headers.addAll(headers);
    request.fields.addAll(body);
    request.files.add(multipartFile);

    // final response = await http.post(
    //   Uri.parse(url),
    //   headers: headers,
    //   body: body,
    // );

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    print(json.decode(responsed.body));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal melakukan checkout!');
    }
  }
}
