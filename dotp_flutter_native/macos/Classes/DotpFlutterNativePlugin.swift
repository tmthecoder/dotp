import Cocoa
import FlutterMacOS

public class DotpFlutterNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dotp_flutter_native", binaryMessenger: registrar.messenger)
    let instance = DotpFlutterNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
//     get_current_totp_from_utf8("", 0);
//     get_current_totp_from_base32("", 0);
       get_otp_from_uri("");
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
