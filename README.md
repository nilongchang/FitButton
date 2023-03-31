# FitButton

[![CI Status](https://img.shields.io/travis/倪龙昌/FitButton.svg?style=flat)](https://travis-ci.org/倪龙昌/FitButton)
[![Version](https://img.shields.io/cocoapods/v/FitButton.svg?style=flat)](https://cocoapods.org/pods/FitButton)
[![License](https://img.shields.io/cocoapods/l/FitButton.svg?style=flat)](https://cocoapods.org/pods/FitButton)
[![Platform](https://img.shields.io/cocoapods/p/FitButton.svg?style=flat)](https://cocoapods.org/pods/FitButton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FitButton is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FitButton'
```
        let button = FitButton(type: .custom)
        // 设置图片和文字的间距
        button.spacing = 10
        // 设置图片位置
        button.imagePosition = .bottom
        // 设置内边距(非必须)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 正常UIButton的设置
        button.setTitle("FitButton", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(named: "read"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
## Author

倪龙昌, 396183258@qq.com

## License

FitButton is available under the MIT license. See the LICENSE file for more info.
