import 'package:flutter/material.dart';
import 'package:jamur/models/user_model.dart';
import 'package:jamur/providers/auth_provider.dart';
import 'package:jamur/providers/history_provider.dart';
import 'package:jamur/theme.dart';
// import 'package:jamur/widgets/chat_tile.dart';
import 'package:jamur/widgets/history_tile.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    HistoryProvider historyProvider = Provider.of<HistoryProvider>(context);
    historyProvider.getHistory(user.token!);
    // final histories = historyProvider.histories;

    Widget header(){
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Histori Transaksi',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget emptyChat() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: backgroundColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon_empty_cart.png',
                width: 80,
              ),
              const SizedBox(height: 20,),
              Text(
                'Ups! Histori masih kosong',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(height: 12,),
              Text(
                'Belum pernah belanja?',
                style: secondaryTextStyle,
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Belanja',
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
      );
    }

    Widget content() {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child:
                  Column(
                    children: historyProvider.histories
                        .map(
                          (history) => HistoryTile(history),
                        )
                        .toList(),
                    ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        header(),
        // emptyChat(),
        historyProvider.histories.isEmpty ? emptyChat() : content(),
      ],
    );
  }
}