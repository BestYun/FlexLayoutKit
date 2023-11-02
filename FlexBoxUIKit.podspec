
Pod::Spec.new do |spec|
  spec.name         = "FlexBoxUIKit"
  spec.version      = "0.0.2"
  spec.summary      = "flex layout for iOS powered by yoga"
  spec.homepage     = "https://github.com/BestYun/FlexBoxUIKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "yun" => "lixingyunxing@163.com" }
  spec.platform     = :ios, "10.0"
  spec.swift_versions = ["5.4"]
  spec.ios.frameworks = 'UIKit'
  spec.module_name = 'FlexBoxUIKit'
#  spec.source = {:path =>"."}
  spec.source       = { :git => "https://github.com/BestYun/FlexBoxUIKit.git", :tag => "#{spec.version}" }
  
  spec.description = <<-DESC
  flex layout for iOS powered by yoga. Like SwiftUI.
                   DESC
  
  spec.default_subspec = 'Core'


  spec.subspec 'Core' do |ss|
    ss.source_files = "Sources/Core/**/*.swift"
    ss.dependency 'FlexBoxYogaKit', '~> 2.0.0.3'
    
  end

   spec.subspec 'Kingfisher' do |ss|
     ss.dependency 'FlexBoxUIKit/Core'
     ss.source_files = "Sources/Kingfisher/*.swift"
     ss.dependency 'Kingfisher', '~> 6.3.1'
   end
  
   spec.subspec 'SDWebImage' do |ss|
     ss.source_files = "Sources/SDWebImage/*.swift"
     ss.dependency 'SDWebImage' #, '~> 6.3.1'
     ss.dependency 'FlexBoxUIKit/Core'
     
   end

end
