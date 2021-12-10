import 'package:web3dart/web3dart.dart';

import 'erc20_contract.dart';

class SwapTokenContract extends ERC20Contract {
  SwapTokenContract({
    required Web3Client web3Client,
    required String contractHexAddress,
  }) : super(
          web3Client: web3Client,
          contractAbiPath: 'assets/erc20.json',
          contractName: 'SWAP',
          contractHexAddress: contractHexAddress,
        );
}
