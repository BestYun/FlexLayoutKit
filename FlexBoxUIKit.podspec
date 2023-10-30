
Pod::Spec.new do |spec|

  spec.name         = "FlexBoxUIKit"
  spec.version      = "0.0.1"
  spec.summary      = "A flexbox of FlexBoxUIKit."
  spec.homepage     = "https://github.com/BestYun/FlexBoxUIKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "yun" => "lixingyunxing@163.com" }
  spec.platform     = :ios, "9.0"
  spec.swift_versions = ["5.4"]
  spec.ios.frameworks = 'UIKit'
  spec.module_name = 'FlexBoxUIKit'
  spec.source = {:path =>"."}
  
  spec.description = <<-DESC
                    A flexbox of FlexBoxUIKit
                   DESC
  
  spec.default_subspec = 'Core'

  # spec.source       = { :git => "https://github.com/BestYun/FlexBoxUIKit.git", :tag => "#{spec.version}" }
  # spec.source_files = "Sources/**/*.{swift,h,m,mm,cpp,c}"
  # spec.public_header_files = "Sources/yoga/{Yoga,YGEnums,YGMacros,YGValue}.h", "Sources/YogaKit/{YGLayout,UIView+Yoga}.h"
  # spec.private_header_files = 'Sources/YogaKit/YGLayout+Private.h'

#  spec.compiler_flags = [
#       '-fno-omit-frame-pointer',
#       '-fexceptions',
#       '-Wall',
#       '-Werror',
#       '-Wextra',
#       '-std=c++14',
#       '-fPIC'
#   ]


  # spec.subspec 'Yoga' do |ss|
  #   # ss.module_name = 'yoga'
  #   ss.source_files = 'Sources/yoga/**/*.{h,cpp}'
  #   ss.public_header_files = 'Sources/yoga/{Yoga,YGEnums,YGMacros,YGValue}.h'
  #   ss.pod_target_xcconfig = {
  #     'DEFINES_MODULE' => 'YES'
  #   }
  #   ss.compiler_flags = [
  #       '-fno-omit-frame-pointer',
  #       '-fexceptions',
  #       '-Wall',
  #       '-Werror',
  #       '-Wextra',
  #       '-std=c++14',
  #       '-fPIC'
  #   ]
  # end

  # spec.subspec 'YogaKit' do |ss|
  #   ss.ios.frameworks = 'UIKit'
  #   ss.dependency 'FlexBoxUIKit/Yoga'
  #   ss.source_files = 'Sources/YogaKit/*.{h,m,swift}'
  #   ss.public_header_files = 'Sources/YogaKit/{YGLayout,UIView+Yoga}.h'
  #   ss.private_header_files = 'Sources/YogaKit/YGLayout+Private.h'

  # end

  spec.subspec 'Core' do |ss|
    ss.source_files = "Sources/**/*.{swift,h,m,mm,cpp,c}"
    ss.public_header_files = "Sources/yoga/{Yoga,YGEnums,YGMacros,YGValue}.h", "Sources/YogaKit/{YGLayout,UIView+Yoga}.h"
    ss.private_header_files = 'Sources/YogaKit/YGLayout+Private.h'
  end

  # spec.subspec 'Kingfisher' do |ss|
  #   ss.dependency 'Kingfisher', '~> 6.3.1'
  # end

end
