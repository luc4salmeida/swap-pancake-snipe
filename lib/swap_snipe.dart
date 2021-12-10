import 'package:web3dart/web3dart.dart';

import 'blockchain/blockchain.dart';
import 'consts.dart';
import 'contracts/contracts.dart';

class SwapBot {
  final Web3Client web3Client;
  final String swapTokenAddr;

  SwapBot({
    required this.web3Client,
    required this.swapTokenAddr,
  }) {
    _createContracts();
  }
  late Chain chain;
  late WBNBContract wbnbContract;
  late RouterContract routerContract;
  late FactoryContract factoryContract;
  late ERC20Contract erc20contract;

  _createContracts() {
    chain = BinanceSmartChain(
      web3Client: web3Client,
    );

    wbnbContract = WBNBContract(
      web3Client: web3Client,
    );

    routerContract = RouterContract(
      web3Client: web3Client,
    );

    factoryContract = FactoryContract(
      web3Client: web3Client,
    );

    erc20contract = SwapTokenContract(
      web3Client: web3Client,
      contractHexAddress: swapTokenAddr,
    );
  }

  Future<void> run() async {
    await _buy(swapTokenAddr);
  }

  Future<void> _buy(String swapTokenAddr) async {
    double amountMinOut = 0;
    double amountMaxOut = 0;

    final amountIn = EtherAmount.fromUnitAndValue(
      EtherUnit.gwei,
      BotConsts.buyAmountGwei,
    );

    if (BotConsts.slippage > 0) {
      final amountsOut = await routerContract.getAmountsOut(
        amountIn.getInWei,
        EthereumAddress.fromHex(BotConsts.wbnbAddress),
        EthereumAddress.fromHex(swapTokenAddr),
      );

      amountMaxOut = (amountsOut[1] as BigInt).toDouble();
      amountMinOut =
          (amountMaxOut - (amountMaxOut * (BotConsts.slippage / 100)));
    }

    final gasPrice = EtherAmount.fromUnitAndValue(
      EtherUnit.gwei,
      BotConsts.gasPrice,
    );

    final amountMinOutWei = EtherAmount.inWei(BigInt.from(amountMinOut));

    print('Efetuando compra...');

    final tx = await routerContract.swapExactTokensForTokens(
      amountIn.getInWei,
      amountMinOutWei.getInWei,
      EthereumAddress.fromHex(BotConsts.wbnbAddress),
      EthereumAddress.fromHex(swapTokenAddr),
      BotConsts.privateAddr,
      DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 5, // 5 minutos
      gasPrice,
      BotConsts.gasLimit,
    );

    print('https://www.bscscan.com/tx/$tx');
  }
}
