import 'dart:typed_data';

/// Made by Tejas Mehta
/// Made on Tuesday, January 18, 2022
/// File Name: hotp.dart

abstract class HOTP {
  Future<int> fromBytes(Uint8List secret, {
    counterValue = 0,
    digits = 6
  });
  Future<int> fromUTF8(String secret, {
    counterValue = 0,
    digits = 6
  });
  Future<int> fromBase32(String secret, {
    counterValue = 0,
    digits = 6
  });
}
