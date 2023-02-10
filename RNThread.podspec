require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name           = "RNThread"
  s.version        = package['version']
  s.summary        = "React native threads"
  s.description    = "React native threads"
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = "https://github.com/joltup/RNThread.git"
  s.source       = { :git => "https://github.com/joltup/RNThread.git", :tag => s.version }
  s.source_files  = "ios/**/*.{h,m}"
  s.platform      = :ios, "11.0"
  s.tvos.deployment_target = '10.0'
  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/Headers/Private/React-Core\"",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17",
    }

    s.dependency "React-Codegen"
    s.dependency "RCT-Folly"
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
  end
  s.dependency 'React'
end
