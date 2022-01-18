import Cocoa
import FlutterMacOS

public class DotpNativePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dotp_native", binaryMessenger: registrar.messenger)
    let instance = DotpNativePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    get_current_totp_from_utf8("", 0);
    get_current_totp_from_base32("", 0);
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
