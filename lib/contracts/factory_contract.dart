import 'package:web3dart/web3dart.dart';

import 'smart_contract.dart';

class FactoryContract extends SmartContract {
  FactoryContract({
    required Web3Client web3Client,
  }) : super(
          web3Client: web3Client,
          contractAbiPath: 'assets/factory.json',
          contractName: 'PancakeSwap: Factory V2',
          contractHexAddress: '0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73',
        );

  Future<String?> getPair(
    EthereumAddress tokenIn,
    EthereumAddress tokenOut,
  ) async {
    final contract = await deployedContract();
    final fun = contract.function('getPair');

    final result = await web3Client.call(
      contract: contract,
      function: fun,
      params: [tokenIn, tokenOut],
    );

    return result.isEmpty ? null : (result.first as EthereumAddress).hex;
  }
}
