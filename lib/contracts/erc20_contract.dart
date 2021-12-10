import 'package:web3dart/web3dart.dart';
import 'smart_contract.dart';

class ERC20Contract extends SmartContract {
  ERC20Contract({
    required Web3Client web3Client,
    required String contractAbiPath,
    required String contractName,
    required String contractHexAddress,
  }) : super(
          web3Client: web3Client,
          contractAbiPath: contractAbiPath,
          contractName: contractName,
          contractHexAddress: contractHexAddress,
        );

  Future<BigInt> balanceOf(EthereumAddress address) async {
    final contract = await deployedContract();
    final fun = contract.function('balanceOf');

    final result = await web3Client.call(
      contract: contract,
      function: fun,
      params: [address],
    );

    return result[0];
  }
}
