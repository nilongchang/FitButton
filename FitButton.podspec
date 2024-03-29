#
# Be sure to run `pod lib lint FitButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FitButton'
  s.version          = '1.1.2'
  s.summary          = '更改图片和文字位置, 设置图片的大小, 灵活设置间距,自动计算宽高'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/nilongchang/FitButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nilongchang' => '396183258@qq.com' }
  s.source           = { :git => 'https://github.com/nilongchang/FitButton.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'FitButton/Classes/**/*'
  
  s.swift_version = '5.0'
end
