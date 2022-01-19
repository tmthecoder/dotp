#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dotp_flutter_native.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dotp_flutter_native'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter implementation of the HOTP and TOTP algorithms'
  s.description      = <<-DESC
A Flutter implementation of the HOTP and TOTP algorithms
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.public_header_files = 'Classes**/*.h'
  s.vendored_libraries = '**/*.a'
  s.static_framework = true
  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
