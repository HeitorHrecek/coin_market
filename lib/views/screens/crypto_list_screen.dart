import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../viewmodels/crypto_view_model.dart';
import '../widgets/crypto_card.dart';
import '../widgets/crypto_detail_sheet.dart';
import '../../models/crypto.dart'; 

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({Key? key}) : super(key: key);

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _searchController = TextEditingController();
  final _refreshController = RefreshController(initialRefresh: true);

  void _openDetails(Crypto crypto) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CryptoDetailSheet(crypto: crypto),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CryptoViewModel>();

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Crypto Market'),
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search symbols: BTC,ETH',
                hintStyle: TextStyle(color: Colors.orange.shade800),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.deepOrange.shade400, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.orange.shade300),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.deepOrange),
                  onPressed: () => viewModel.fetchCryptos(_searchController.text),
                ),
              ),
              onSubmitted: viewModel.fetchCryptos,
            ),
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: () async {
                await viewModel.fetchCryptos(_searchController.text);
                _refreshController.refreshCompleted();
              },
              child: Builder(
                builder: (_) {
                  if (viewModel.isLoading) {
                    return Center(child: CircularProgressIndicator(color: Colors.deepOrange));
                  }
                  if (viewModel.errorMessage.isNotEmpty) {
                    return Center(child: Text(
                      viewModel.errorMessage,
                      style: TextStyle(color: Colors.red.shade800),
                    ));
                  }
                  if (viewModel.cryptos.isEmpty) {
                    return Center(child: Text(
                      'No data available',
                      style: TextStyle(color: Colors.orange.shade800),
                    ));
                  }

                  return ListView.builder(
                    itemCount: viewModel.cryptos.length,
                    itemBuilder: (_, i) {
                      final crypto = viewModel.cryptos[i];
                      return GestureDetector(
                        onTap: () => _openDetails(crypto),
                        child: CryptoCard(crypto: crypto),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
