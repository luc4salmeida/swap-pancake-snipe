import 'package:web3dart/web3dart.dart';

import 'chain.dart';

class BinanceSmartChain implements Chain {
  final Web3Client web3Client;

  BinanceSmartChain({
    required this.web3Client,
  });

  @override
  Future<TransactionReceipt?> getReceipt(String hash) {
    return web3Client.getTransactionReceipt(hash);
  }

  @override
  Future<EtherAmount> getBalanceOf(EthereumAddress address) {
    return web3Client.getBalance(address);
  }
}
