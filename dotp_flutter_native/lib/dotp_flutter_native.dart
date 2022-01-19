
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

typedef OTPFromUTF8 = int Function(Pointer<Utf8>, int);
typedef OTPFromUTF8FFI = Uint32 Function(Pointer<Utf8>, Uint8);

class DotpFlutterNative {
  final DynamicLibrary _xotp = Platform.isAndroid
      ? DynamicLibrary.open("libxotp_ffi.so")
      : DynamicLibrary.process();

  void lookup() {
    final OTPFromUTF8 function =_xotp
        .lookup<NativeFunction<OTPFromUTF8FFI>>("get_current_totp_from_utf8")
        .asFunction();
    String secret = "12345678901234567890";
    Pointer<Utf8> secretPtr = secret.toNativeUtf8();
    int code = function(secretPtr, 0x1);
    malloc.free(secretPtr);
    print("CODE: $code");
  }
}
