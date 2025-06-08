import 'package:flutter/material.dart';
import 'package:coin_market/data/crypto_data_source.dart';
import 'package:coin_market/repositories/crypto_repository.dart';
import 'package:provider/provider.dart';
import 'viewmodels/crypto_view_model.dart';
import 'views/screens/crypto_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CryptoViewModel(CryptoRepository(CryptoDataSource()))),
      ],
      child: MaterialApp(
        title: 'Crypto Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
            primary: Colors.orange,
            secondary: Colors.deepOrange,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
        home: const CryptoListScreen(),
      ),
    );
  }
}
