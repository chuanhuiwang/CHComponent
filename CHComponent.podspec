#
# Be sure to run `pod lib lint CHComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHComponent'
  s.version          = '0.2.0'
  s.summary          = 'CHComponent, UI组件库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CHComponent, UI组件库,
自定义按钮: 左图右字，右图左字，上图下字，下图上字，图片缩放，间距设置, maximumIntrinsicContentRect = true 时，图片和文字显示在两边, 可设置文字显示行数
                       DESC

  s.homepage         = 'https://github.com/chuanhuiwang/CHComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '372020909@qq.com' => '372020909@qq.com' }
  s.source           = { :git => 'https://github.com/chuanhuiwang/CHComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CHComponent/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CHComponent' => ['CHComponent/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.swift_version = '4.0'
end
