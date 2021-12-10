# Swap Pancake Bot

Swap Pancake Bot foi feito para fazer swaps instantâneos sem necessidade de importar um novo Token no site da PancakeSwap, fazendo assim ganhar alguns segundos de vantagem encima da concorrência.

## Installation

Entre no site do dart e instale  o mesmo na sua maquina.

[Dart Installation Tutorial](https://dart.dev/get-dart)

## Transaction configurations

Acesse o arquivo **lib/consts.dart**\
Configure essas constantes para algo que te agrade.

```dart
abstract class BotConsts {
  static const String privateAddr = ''; // Your private key here
  static const String wbnbAddress =
      '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c';

  static const int buyAmountGwei = 300000000; // 0.3 bnb
  static const int minLiquidity = 3;

  static const int slippage = 5; // 0.05%
  static const int gasPrice = 6; // in gWei

  static const int gasLimit = 215684;
}
```

## Usage

Entre na pasta **bin/**
e execute o seguinte comando:

```bash
dart swap_snipe.dart
```

Após executado o bot vai te perguntar qual endereço você deseja trocar:
```
'Digite o endereço do token: '
```

Lembre-se por default está WBNB -> TOKEN, caso queria fazer uma troca diferente será necessário alterar o endereço do contrato no **BotConstants**.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)