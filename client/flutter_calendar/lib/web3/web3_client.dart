import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

mixin Web3ClientDart {
  static final client = Web3Client(
    "https://mainnet.infura.io/v3/36229aa90d54478bb93614edd05f06b0",
    Client(),
  );
}
