import 'dart:typed_data';

abstract class TOTP {
  Future<int> fromBytes(Uint8List secret, {
    digits = 6
  });
  Future<int> fromUTF8(String secret, {
    digits = 6
  });
  Future<int> fromBase32(String secret, {
    digits = 6
  });
}
