import 'package:flutter/material.dart';
import '../../models/crypto.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/formatter.dart';

class CryptoCard extends StatelessWidget {
  final Crypto crypto;

  const CryptoCard({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text('${crypto.symbol} - ${crypto.name}', style: AppStyles.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('USD: ${Formatter.usd(crypto.priceUsd)}'),
              Text('BRL: ${Formatter.brl(crypto.priceBrl)}'),
            ],
          ),
        ),
      ),
    );
  }
}
