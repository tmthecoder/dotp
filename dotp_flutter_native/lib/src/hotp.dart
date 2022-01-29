/// Made by Tejas Mehta
/// Made on Saturday, January 29, 2022
/// File Name: hotp.dart
/// Package: lib.src

import 'dart:ffi';

import 'package:dotp_flutter_native/src/otp_algorithm.dart';
import 'package:dotp_flutter_native/xotp.dart' as xotp;

class HOTP extends OTPAlgorithm {

  final Pointer<xotp.HOTP> hotpRef;
  int counter;

  HOTP(this.hotpRef, this.counter);

  @override
  int getOtp() {
    int otp = xotp.XOTP().hotp_get_otp(hotpRef, counter);
    counter++;
    return otp;
  }

  @override
  void destroy() {

  }

}
