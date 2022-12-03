import 'package:convert/convert.dart';

String bytesToHex(List<int> bytes, {bool include0x = false}) {
  return (include0x ? "0x" : "") + hex.encode(bytes);
}

extension MaskExtension on String {
  String mask({digit = 8}) =>
      (length > digit) ? "${substring(0, digit)}..." : this;
  String prefixMask({int digit = 6}) => "...${substring(length - digit)}";
  String get addressAbbreviation =>
      "${substring(0, 4)}...${substring(length - 4, length)}";
  String customAbbrevation({int start = 4, int end = 4}) =>
      "${substring(0, start)}...${substring(length - end, length)}";
}
