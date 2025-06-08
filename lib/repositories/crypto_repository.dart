import '../models/crypto.dart';
import '../data/crypto_data_source.dart';
import '../exceptions/crypto_exception.dart';

class CryptoRepository {
  final CryptoDataSource _dataSource;

  CryptoRepository(this._dataSource);

  Future<List<Crypto>> getCryptos(List<String> symbols) async {
    try {
      final brlRate = await _fetchBrlExchangeRate();
      final rawData = await _dataSource.fetchCryptoData(symbols);

      return rawData
          .map((json) => Crypto.fromJson(json, brlRate))
          .toList();
    } catch (e) {
      throw CryptoException('Erro na busca de criptomoedas');
    }
  }

  Future<double> _fetchBrlExchangeRate() async {
    return _dataSource.fetchBrlRate();
  }
}
