/// Made by Tejas Mehta
/// Made on Saturday, January 29, 2022
/// File Name: util.dart
/// Package: lib.src

import 'dart:ffi';

import 'package:dotp_flutter_native/src/hotp.dart';
import 'package:dotp_flutter_native/src/totp.dart';
import 'package:dotp_flutter_native/src/xotp.dart' hide HOTP, TOTP;
import 'package:ffi/ffi.dart';

import 'otp_algorithm.dart';

OTPAlgorithm getOTPFromURI(String uri) {
  Pointer<OTPResult> hashResult = XOTP().get_otp_from_uri(uri.toNativeUtf8());
  switch (hashResult.ref.tag) {
    case OTPResult_Tag.ParsedHOTP:
      return HOTP(
          hashResult.ref.body.hotpBody.hotpPtr,
          hashResult.ref.body.hotpBody.counter
      );
    case OTPResult_Tag.ParsedTOTP:
     return TOTP(
       hashResult.ref.body.totpPtr
     );
    case OTPResult_Tag.Error:
    default:
      throw Exception("Parse error");
  }
}
