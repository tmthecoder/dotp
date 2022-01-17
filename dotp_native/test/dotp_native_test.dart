import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dotp_native/dotp_native.dart';

void main() {
  const MethodChannel channel = MethodChannel('dotp_native');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
  });
}
