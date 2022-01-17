#import "DotpNativePlugin.h"
#if __has_include(<dotp_native/dotp_native-Swift.h>)
#import <dotp_native/dotp_native-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dotp_native-Swift.h"
#endif
#import "xotp_bindings.h"
@implementation DotpNativePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDotpNativePlugin registerWithRegistrar:registrar];
    get_current_totp_from_utf8("", 0);
    get_current_totp_from_base32("", 0);
}
@end
