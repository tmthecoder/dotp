import Cocoa
import FlutterMacOS

public class DotpFlutterNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dotp_flutter_native", binaryMessenger: registrar.messenger)
    let instance = DotpFlutterNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
       get_otp_from_uri("");
       totp_get_otp(nil);
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
