import 'package:flutter/material.dart';
import 'package:jamur/models/history_model.dart';

class HistoryTile extends StatelessWidget {
  final HistoryModel history;
  const HistoryTile(this.history, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rp ${history.totalPrice}',
                    // 'Rp',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    history.status!,
                    // 'lunas',
                    style: const TextStyle(
                      fontSize: 12,
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
