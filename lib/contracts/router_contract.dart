import 'package:swap_snipe/contracts/smart_contract.dart';
import 'package:web3dart/web3dart.dart';

class RouterContract extends SmartContract {
  RouterContract({
    required Web3Client web3Client,
  }) : super(
          web3Client: web3Client,
          contractAbiPath: 'assets/router.json',
          contractName: 'PancakeSwap: Router v2',
          contractHexAddress: '0x10ed43c718714eb63d5aa57b78b54704e256024e',
        );

  Future<List<dynamic>> getAmountsOut(
    BigInt ammountIn,
    EthereumAddress tokenIn,
    EthereumAddress tokenOut,
  ) async {
    final result = await query(
      'getAmountsOut',
      [
        ammountIn,
        [
          tokenIn,
          tokenOut,
        ]
      ],
    );

    return List.from(result[0]);
  }

  Future<String> swapExactTokensForTokensSupportingFeeOnTransferTokens(
    BigInt amountOut,
    BigInt amountInMax,
    EthereumAddress tokenIn,
    EthereumAddress tokenOut,
    String ethPrivateHex,
    int deadLine,
    EtherAmount gasPrice,
    int gasLimit,
  ) async {
    final cred = EthPrivateKey.fromHex(ethPrivateHex);
    final walletAddress = EthereumAddress.fromPublicKey(cred.encodedPublicKey);

    final result = submit(
      ethPrivateHex,
      'swapExactTokensForTokensSupportingFeeOnTransferTokens',
      [
        amountOut,
        amountInMax,
        [tokenIn, tokenOut],
        walletAddress,
        BigInt.from(deadLine),
      ],
      gasPrice: gasPrice,
      gasMax: gasLimit,
    );

    return result;
  }

  Future<String> swapExactTokensForTokens(
    BigInt amountOut,
    BigInt amountInMax,
    EthereumAddress tokenIn,
    EthereumAddress tokenOut,
    String ethPrivateHex,
    int deadLine,
    EtherAmount gasPrice,
    int gasLimit,
  ) async {
    final cred = EthPrivateKey.fromHex(ethPrivateHex);
    final walletAddress = EthereumAddress.fromPublicKey(cred.encodedPublicKey);

    final result = submit(
      ethPrivateHex,
      'swapExactTokensForTokens',
      [
        amountOut,
        amountInMax,
        [tokenIn, tokenOut],
        walletAddress,
        BigInt.from(deadLine),
      ],
      gasPrice: gasPrice,
      gasMax: gasLimit,
    );

    return result;
  }
}
