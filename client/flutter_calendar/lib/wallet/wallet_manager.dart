import 'dart:math'; //used for the random number generator

import 'package:web3dart/web3dart.dart';

class WalletManager {
  late EthPrivateKey privateKey;

  WalletManager._() {}

  WalletManager.createWallet() {
    var rng = Random.secure();
    privateKey = EthPrivateKey.createRandom(rng);
  }

  WalletManager.importWalletFromPrivateKey({required String key}) {
    privateKey = EthPrivateKey.fromHex(key);
  }
}
