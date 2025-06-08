import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../exceptions/crypto_exception.dart';

class CryptoDataSource {
  static const _apiKey = 'c7dc7e6f-758c-4e1f-88b6-50d2caf5982d';
  static const _baseUrl = 'https://pro-api.coinmarketcap.com';

  final http.Client _httpClient;
  final Connectivity _connectivity = Connectivity();

  CryptoDataSource({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<List<Map<String, dynamic>>> fetchCryptoData(List<String> symbols) async {
    final hasInternet = await _checkInternetConnection();
    if (!hasInternet) {
      throw CryptoException('Sem conexão com a Internet. Verifique sua conexão e tente novamente.');
    }

    final url = Uri.parse(
      '$_baseUrl/v1/cryptocurrency/quotes/latest?symbol=${symbols.join(',')}',
    );

    final response = await _httpClient.get(
      url,
      headers: {'X-CMC_PRO_API_KEY': _apiKey},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;

      return data.values.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      throw CryptoException(
        'Erro ao buscar dados das criptos. Status code: ${response.statusCode}',
      );
    }
  }

  
  Future<double> fetchBrlRate() async {
    final hasInternet = await _checkInternetConnection();
    if (!hasInternet) {
      throw CryptoException('Sem conexão com a Internet. Verifique sua conexão e tente novamente.');
    }
    
    return 5.3;
  }
}
