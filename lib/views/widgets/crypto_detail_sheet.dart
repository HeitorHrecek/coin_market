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

    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  '${crypto.name} (${crypto.symbol})', 
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.deepOrange.shade800,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 16),
                Text('Data adicionada: ${crypto.dateAdded}', 
                  style: TextStyle(color: Colors.orange.shade900)),
                const SizedBox(height: 8),
                Text('Preço em USD: ${usdFormat.format(crypto.priceUsd)}',
                  style: TextStyle(color: Colors.deepOrange.shade700, fontWeight: FontWeight.bold)),
                Text('Preço em BRL: ${brlFormat.format(crypto.priceBrl)}',
                  style: TextStyle(color: Colors.deepOrange.shade700, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
