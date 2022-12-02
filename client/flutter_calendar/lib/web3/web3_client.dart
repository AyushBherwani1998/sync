import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

mixin Web3ClientDart {
  static final client = Web3Client(
    "",
    Client(),
  );
}
