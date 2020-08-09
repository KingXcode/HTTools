#
#  Be sure to run `pod spec lint HTTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "HTTools"
  spec.version      = "1.0.0"
  spec.summary      = "项目中常用到的一些分类及工具类"

  spec.homepage     = "https://github.com/KingXcode/HTTools"
  spec.license      = { :type => "MIT",}
  spec.author       = { "niesiyangPC" => "siyang.nie.520@gmail.com" }
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/KingXcode/HTTools.git", :tag => "#{spec.version}" }
  spec.source_files = "HTToolsDemo/HTTools/*.{h,m}"

  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # spec.exclude_files = "Classes/Exclude"
  # spec.public_header_files = "Classes/**/*.h"
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  # spec.requires_arc = true
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
