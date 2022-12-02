import 'package:ens_dart/ens_dart.dart';
import 'package:flutter_calendar/web3/web3_client.dart';
import 'package:web3dart/web3dart.dart';

mixin ENSResolver {
  static Future<String> resolveENS(String ensName) async {
    final Ens ens = Ens(client: Web3ClientDart.client);
    final EthereumAddress ethereumAddress =
        await ens.withName(ensName).getAddress();
    return ethereumAddress.hex;
  }
}
