import 'package:web3dart/web3dart.dart';

abstract class Chain {
  Future<TransactionReceipt?> getReceipt(String hash);
  Future<EtherAmount> getBalanceOf(EthereumAddress address);
}
