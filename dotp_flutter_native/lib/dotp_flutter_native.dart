
import 'dart:ffi';
import 'dart:io';

import 'package:dotp_flutter_native/generated_bindings.dart';
import 'package:ffi/ffi.dart';

typedef OTPFromUTF8 = int Function(Pointer<Utf8>, int);
typedef OTPFromUTF8FFI = Uint32 Function(Pointer<Utf8>, Uint8);

class DotpFlutterNative {
  final DynamicLibrary _xotp = Platform.isAndroid
      ? DynamicLibrary.open("libxotp_ffi.so")
      : DynamicLibrary.process();

  void lookup() {
    print("Lookup");
    Pointer<OTPResult> hashResult = NativeLibrary(_xotp).get_otp_from_uri("otpauth://hotp/ACME%20Co:john.doe@email.com?secret=HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ&issuer=ACME%20Co&digits=8&counter=1234".toNativeUtf8());
    print("Finish ${hashResult.ref.tag}");
  }
}
