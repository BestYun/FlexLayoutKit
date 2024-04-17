#
# Be sure to run `pod lib lint FlexLayoutKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexLayoutKit'
  s.version          = '0.5'
  s.summary      = "flex layout for iOS powered by yoga"

  s.description = <<-DESC
flex layout for iOS powered by yoga. Like SwiftUI.
                 DESC

  s.homepage         = 'https://github.com/BestYun/FlexLayoutKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yun' => 'lixingyunxing@163.com' }
  s.source           = { :git => 'https://github.com/BestYun/FlexLayoutKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_versions = ["5.4"]
  s.module_name = 'FlexLayoutKit'
  s.default_subspec = 'Core'


  s.subspec 'Core' do |ss|
    ss.source_files = "FlexLayoutKit/Sources/Core/**/*.{swift,h,m,mm,cpp,c}","FlexLayoutKit/Sources/YogaKit/*.{swift,h,m,mm,cpp,c}"
    ss.public_header_files =  "FlexLayoutKit/Sources/YogaKit/*.h"
    ss.frameworks = 'UIKit'
    ss.dependency 'FlexBoxYoga', "~> 2.0.0.2"
  end

  s.subspec 'Kingfisher' do |ss|
    ss.dependency 'FlexLayoutKit/Core'
    ss.source_files = "FlexLayoutKit/Sources/Kingfisher/*.{swift}"
    ss.dependency 'Kingfisher', '~> 6.3.1'
  end
 
  s.subspec 'SDWebImage' do |ss|
    ss.source_files = "FlexLayoutKit/Sources/SDWebImage/*.swift"
    ss.dependency 'SDWebImage' 
    ss.dependency 'FlexLayoutKit/Core'
    
  end

end
