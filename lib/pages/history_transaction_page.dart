import 'package:flutter/material.dart';
import 'package:jamur/models/user_model.dart';
import 'package:jamur/providers/auth_provider.dart';
import 'package:jamur/providers/history_provider.dart';
import 'package:jamur/theme.dart';
import 'package:jamur/widgets/history_tile.dart';
import 'package:provider/provider.dart';

class HistoryTransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    UserModel user = authProvider.user;

    HistoryProvider historyProvider = Provider.of<HistoryProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'History Transaksi',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      );
    }

    Widget content() {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(30),
              child:
                  // Column(
                  //   children: [
                  //     HistoryTile(),
                  //     HistoryTile(),
                  //   ],
                  // ),
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

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
