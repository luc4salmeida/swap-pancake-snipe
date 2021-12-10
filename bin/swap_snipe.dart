import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:swap_snipe/swap_snipe.dart';
import 'package:web3dart/web3dart.dart';

// THC TOKEN
// '0x24802247bd157d771b7effa205237d8e9269ba8a'

void main(List<String> arguments) {
  final httpClient = http.Client();

  final web3Client = Web3Client(
    'https://bsc-dataseed1.ninicoin.io/',
    httpClient,
  );

  String? swapToken;

  do {
    print('Digite o endereço do token: ');
    final line = stdin.readLineSync(encoding: utf8);

    if (line == null) {
      print('Digite um endereço de token válido!');
    }

    swapToken = line;
  } while (swapToken == null);

  final SwapBot bot = SwapBot(
    web3Client: web3Client,
    swapTokenAddr: swapToken,
  );

  bot.run();
}
