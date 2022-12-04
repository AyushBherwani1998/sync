import 'package:ens_dart/ens_dart.dart';
import 'package:flutter_calendar/web3/web3_client.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

mixin ENSResolver {
  static final Ens ens = Ens(client: Web3ClientDart.ensClient);
  
  static Future<String> resolveENS(String ensName) async {
    final EthereumAddress ethereumAddress =
        await ens.withName(ensName).getAddress();
    return ethereumAddress.hex;
  }

  /// Returns null if no ENS is registered
  static Future<String?> getENS(String address) async {
    try {
      final EthereumAddress ethereumAddress = EthereumAddress.fromHex(address);
      final String resolvedEns =
          await ens.withAddress(ethereumAddress).getName();
      return resolvedEns;
    } catch (e, stackTrace) {
      Vx.log(
        "ReverseENS: $e, ${stackTrace.toString()}",
      );
      return null;
    }
  }
}
