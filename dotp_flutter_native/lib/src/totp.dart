/// Made by Tejas Mehta
/// Made on Saturday, January 29, 2022
/// File Name: totp.dart
/// Package: lib.src

import 'dart:ffi';

import 'package:dotp_flutter_native/src/otp_algorithm.dart';
import 'package:dotp_flutter_native/src/xotp.dart' as xotp;

class TOTP extends OTPAlgorithm {

  Pointer<xotp.TOTP> totpRef;

  TOTP(this.totpRef);

  @override
  int getOtp() {
   return xotp.XOTP().totp_get_otp(totpRef);
  }

  // Until finalizers are added into Dart, we have to manually
  // dispose of the pointer
  @override
  void destroy() {
    xotp.XOTP().totp_free(totpRef);
  }

}
