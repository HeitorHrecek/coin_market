import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/crypto.dart';

class CryptoDetailSheet extends StatelessWidget {
  final Crypto crypto;

  const CryptoDetailSheet({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Center(
            child: Column(
              children: [
                Text('${crypto.name} (${crypto.symbol})', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Text('Data adicionada: ${crypto.dateAdded}'),
                const SizedBox(height: 8),
                Text('Preço em USD: ${usdFormat.format(crypto.priceUsd)}'),
                Text('Preço em BRL: ${brlFormat.format(crypto.priceBrl)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
