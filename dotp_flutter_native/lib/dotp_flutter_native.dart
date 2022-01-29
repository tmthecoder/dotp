
import 'dart:ffi';
import 'dart:io';

import 'package:dotp_flutter_native/xotp.dart';
import 'package:ffi/ffi.dart';

typedef OTPFromUTF8 = int Function(Pointer<Utf8>, int);
typedef OTPFromUTF8FFI = Uint32 Function(Pointer<Utf8>, Uint8);

class DotpFlutterNative {
  final DynamicLibrary _xotp = Platform.isAndroid
      ? DynamicLibrary.open("libxotp_ffi.so")
      : DynamicLibrary.process();

  void lookup() {
    print("Lookup");
    XOTP library = XOTP();
    Pointer<OTPResult> hashResult = library.get_otp_from_uri("otpauth://totp/ACME%20Co:john@example.com?secret=27FLAJRGS7VE3MUFZMOYFJTCD4TDPCOT&issuer=ACME%20Co&algorithm=SHA1&digits=6&period=30".toNativeUtf8());
    print("Got result");
    switch (hashResult.ref.tag) {
      case OTPResult_Tag.ParsedHOTP:
        int otp = library.hotp_get_otp(hashResult.ref.body.hotpBody.hotpPtr, hashResult.ref.body.hotpBody.counter);
        print("HOTP: $otp");
        break;
      case OTPResult_Tag.ParsedTOTP:
        int otp = library.totp_get_otp(hashResult.ref.body.totpPtr);
        print("TOTP: $otp");
        break;
      case OTPResult_Tag.Error:
        print("ERROR");
        break;
    }
  }
}
