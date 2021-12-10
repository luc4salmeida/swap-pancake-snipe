import 'package:swap_snipe/contracts/erc20_contract.dart';
import 'package:web3dart/web3dart.dart';

class WBNBContract extends ERC20Contract {
  WBNBContract({
    required Web3Client web3Client,
  }) : super(
          web3Client: web3Client,
          contractAbiPath: 'assets/bnb.json',
          contractName: 'WBNB',
          contractHexAddress: '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
        );
}
