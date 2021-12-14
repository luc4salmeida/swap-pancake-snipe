import 'dart:io';

import 'package:web3dart/web3dart.dart';

abstract class ISmartContract {
  Future<String> submit(
    String hexPrivateKey,
    String functionName,
    List<dynamic> args, {
    EtherAmount? gasPrice,
    EtherAmount? value,
  });

  Future<List<dynamic>> query(
    String functionName,
    List<dynamic> args,
  );
}

class SmartContract implements ISmartContract {
  final Web3Client web3Client;

  final String contractAbiPath;
  final String contractName;
  final String contractHexAddress;

  SmartContract({
    required this.web3Client,
    required this.contractAbiPath,
    required this.contractName,
    required this.contractHexAddress,
  });

  Future<DeployedContract> deployedContract() async {
    final abiJson = await File(contractAbiPath).readAsString();

    final contract = DeployedContract(
      ContractAbi.fromJson(abiJson, contractName),
      EthereumAddress.fromHex(contractHexAddress),
    );

    return contract;
  }

  @override
  Future<List> query(String functionName, List args) async {
    final contract = await deployedContract();
    final fun = contract.function(functionName);

    return web3Client.call(contract: contract, function: fun, params: args);
  }

  @override
  Future<String> submit(
    String hexPrivateKey,
    String functionName,
    List args, {
    EtherAmount? gasPrice,
    int? gasMax,
    EtherAmount? value,
  }) async {
    final credentials = EthPrivateKey.fromHex(hexPrivateKey);

    final contract = await deployedContract();
    final fun = contract.function(functionName);

    return web3Client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: fun,
        parameters: args,
        gasPrice: gasPrice,
        maxGas: gasMax,
        value: value,
      ),
      chainId: 56, // Chainid BSC
    );
  }
}
