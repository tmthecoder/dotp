import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dotp_flutter_native/dotp_flutter_native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  OTPAlgorithm algorithm = getOTPFromURI("otpauth://totp/ACME%20Co:john@example.com?secret=27FLAJRGS7VE3MUFZMOYFJTCD4TDPCOT&issuer=ACME%20Co&algorithm=SHA1&digits=6&period=30");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    algorithm.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('OTP: ${algorithm.getOtp()}'),
        ),
      ),
    );
  }
}
