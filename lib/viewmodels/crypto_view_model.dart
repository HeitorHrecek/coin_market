import 'package:flutter/material.dart';
import '../models/crypto.dart';
import '../repositories/crypto_repository.dart';
import '../exceptions/crypto_exception.dart';

class CryptoViewModel extends ChangeNotifier {
  final CryptoRepository _repository;

  CryptoViewModel(this._repository);

  List<Crypto> _cryptos = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Crypto> get cryptos => _cryptos;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  static const List<String> _defaultSymbols = [
    'BTC', 'ETH', 'SOL', 'BNB', 'BCH', 'MKR', 'AAVE', 'DOT', 'SUI', 'ADA',
    'XRP', 'TIA', 'NEO', 'NEAR', 'PENDLE', 'RENDER', 'LINK', 'TON', 'XAI',
    'SEI', 'IMX', 'ETHFI', 'UMA', 'SUPER', 'FET', 'USUAL', 'GALA', 'PAAL', 'AERO'
  ];

  Future<void> fetchCryptos([String? query]) async {
    _setLoading(true);
    _setError('');

    final symbols = _parseSymbols(query);

    try {
      final result = await _repository.getCryptos(symbols);
      _setCryptos(result);
    } on CryptoException catch (e) {
      _setError(e.message);
    } catch (_) {
      _setError('Erro inesperado ao buscar criptomoedas.');
    } finally {
      _setLoading(false);
    }
  }

  List<String> _parseSymbols(String? query) {
    if (query == null || query.trim().isEmpty) return _defaultSymbols;
    return query.split(',').map((s) => s.trim().toUpperCase()).toList();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setCryptos(List<Crypto> newCryptos) {
    _cryptos = newCryptos;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
