import 'package:flutter/material.dart';
import 'package:jamur/models/history_model.dart';
import 'package:jamur/services/history_service.dart';

class HistoryProvider with ChangeNotifier {
  List<HistoryModel> _histories = [];

  List<HistoryModel> get histories => _histories;

  Future<void> getHistory(String token) async {
    try {
      List<HistoryModel> histories = await HistoryService().getHistory(token);
      _histories = histories;

      notifyListeners();
    } catch (e) {
      print(e);
      throw Exception('Gagal mendapatkan history transaksi.'); // Melempar Exception jika terjadi kesalahan
    }
  }
}
