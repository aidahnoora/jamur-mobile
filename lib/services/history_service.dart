import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jamur/models/history_model.dart';

class HistoryService {
  String baseUrl = 'http://192.168.0.107:8000/api';

  Future<List<HistoryModel>> getHistory(String token) async {
    var url = '$baseUrl/transaction';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];

      List<HistoryModel> histories = [];

      for (var item in data) {
        histories.add(HistoryModel.fromJson(item));
      }

      print(response.body);

      return histories;
    } else {
      throw Exception('Gagal mendapatkan history transaksi.');
    }
  }
}
