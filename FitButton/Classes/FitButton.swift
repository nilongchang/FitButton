//
//  FitButton.swift
//  FitButton
//
//  Created by nilongchang on 2023/3/29.
//

import UIKit
import Foundation
import CommonCrypto

/// 设置image和label的位置,自动计算宽高
public class FitButton: UIButton {
    
    public enum ButtonImagePostion {
        case left  // 默认
        case right
        case top
        case bottom
    }
    
    /// 图片位置
    public var imagePosition: ButtonImagePostion = .left
    
    /// 图片和文字的间距
    public var spacing: CGFloat = 0
    
    private var titleSize: CGSize?
    
    public override var titleEdgeInsets: UIEdgeInsets {
        set {
            
        }
        
        get {
            .zero
        }
    }
    
    public override var imageEdgeInsets: UIEdgeInsets {
        set {
            
        }
        
        get {
            .zero
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let originalSize = super.sizeThatFits(size)
        var width: CGFloat = originalSize.width
        var height: CGFloat = originalSize.height
        if imagePosition == .left || imagePosition == .right {
            width += spacing
        } else {
            let imageSize = currentImageSize()
            self.titleSize = currentTitleSize()
            guard let titleSize = self.titleSize else {
                return originalSize
            }
            width = max(imageSize.width, titleSize.width) + HorizontalValue(inset: contentEdgeInsets)
            height = spacing + imageSize.height + titleSize.height + VerticalValue(inset: contentEdgeInsets)
        }
        let newSize = CGSize(width: width, height: height)
        return newSize
    }
    
    public override var intrinsicContentSize: CGSize {
        
        let originalSize = super.intrinsicContentSize
        var width: CGFloat = originalSize.width
        var height: CGFloat = originalSize.height
        if imagePosition == .left || imagePosition == .right {
            width += spacing
        } else {
            let imageSize = currentImageSize()
            guard let titleSize = titleSize else {
                return originalSize
            }
            width = max(imageSize.width, titleSize.width) + HorizontalValue(inset: contentEdgeInsets)
            height = spacing + imageSize.height + titleSize.height + VerticalValue(inset: contentEdgeInsets)
        }
        let newSize = CGSize(width: width, height: height)
        print("intrinsicContentSize: \(originalSize) \(newSize)")
        return newSize
    }
   
    public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.imageRect(forContentRect: contentRect)
        guard let _ = titleSize else {
            return rect
        }
        var newRect: CGRect = .zero
        
        if imagePosition == .left {
            newRect = imageRectAtImagePositionLeft(forContentRect: contentRect)
        } else if imagePosition == .right {
            newRect = imageRectAtImagePositionRight(forContentRect: contentRect)
        } else if imagePosition == .top {
            newRect = imageRectAtImagePositionTop(forContentRect: contentRect)
        }else {
            newRect = imageRectAtImagePositionBottom(forContentRect: contentRect)
        }
        return newRect
    }
    
    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let originalTitleRect = super.titleRect(forContentRect: contentRect)
        guard let _ = titleSize  else {
            if originalTitleRect.width != 0 && originalTitleRect.height != 0 {
                self.titleSize = originalTitleRect.size
            }
            return originalTitleRect
        }
        var newRect: CGRect = .zero
        
        if imagePosition == .left {
            newRect = titleRectAtImagePositionLeft(forContentRect: contentRect)
        } else if imagePosition == .right {
            newRect = titleRectAtImagePositionRight(forContentRect: contentRect)
        } else if imagePosition == .top {
            newRect = titleRectAtImagePositionTop(forContentRect: contentRect)
        }else {
            newRect = titleRectAtImagePositionBottom(forContentRect: contentRect)
        }
        return newRect
    }
    
    private func imageRectAtImagePositionLeft(forContentRect contentRect: CGRect) -> CGRect {
        let imageSize = currentImageSize()
        let titleSize = titleSize ?? .zero
        let imageW = imageSize.width
        let imageH = imageSize.height
        let titleW = titleSize.width
        let totalW = imageW + titleW
        let totalWS = totalW + spacing
        
        var x: CGFloat = 0
        var y: CGFloat = 0
                
        switch contentHorizontalAlignment {
        case .left, .leading:
            x = contentRect.minX
        case .right, .trailing:
            x = contentRect.maxX - totalWS
        default:
            x = contentRect.midX - totalWS / 2.0
        }
        
        switch contentVerticalAlignment {
        case .top:
            y = contentRect.minY
        case .bottom:
            y = contentRect.maxY - imageH
        default:
            y = contentRect.midY - imageH / 2.0
        }
        
        return CGRect(x: x, y: y, width: imageW, height: imageH)
    }
    
    private func titleRectAtImagePositionLeft(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = imageRectAtImagePositionLeft(forContentRect: contentRect)
        let titleSize = titleSize ?? .zero
        let titleW = titleSize.width
        let titleH = titleSize.height
        
        let x: CGFloat = imageRect.maxX + spacing
        var y: CGFloat = 0
        switch contentVerticalAlignment {
        case .top:
            y = contentRect.minY
        case .bottom:
            y = contentRect.maxY - titleH
        default:
            y = contentRect.midY - titleH / 2.0
        }
        return CGRect(x: x, y: y, width: titleW, height: titleH)
    }
    
    private func imageRectAtImagePositionRight(forContentRect contentRect: CGRect) -> CGRect {
        let imageSize = currentImageSize()
        let titleSize = titleSize ?? .zero
        
        let imageW = imageSize.width
        let imageH = imageSize.height
        let titleW = titleSize.width
        let totalW = imageW + titleW
        let totalWS = totalW + spacing
        var x: CGFloat = 0
        var y: CGFloat = 0
                
        switch contentHorizontalAlignment {
        case .left, .leading:
            x = contentRect.minX + titleW + spacing
        case .right, .trailing:
            x = contentRect.maxX - imageW
        default:
            x = contentRect.midX - totalWS / 2.0 + titleW + spacing
        }
        
        switch contentVerticalAlignment {
        case .top:
            y = contentRect.minY
        case .bottom:
            y = contentRect.maxY - imageH
        default:
            y = contentRect.midY - imageH / 2.0
        }
        
        return CGRect(x: x, y: y, width: imageW, height: imageH)
    }
    
    private func titleRectAtImagePositionRight(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = imageRectAtImagePositionRight(forContentRect: contentRect)
        let titleSize = titleSize ?? .zero
        let titleW = titleSize.width
        let titleH = titleSize.height
        let x: CGFloat = imageRect.minX - titleW - spacing
        var y: CGFloat = 0
        switch contentVerticalAlignment {
        case .top:
            y = contentRect.minY
        case .bottom:
            y = contentRect.maxY - titleH
        default:
            y = contentRect.midY - titleH / 2.0
        }
        return CGRect(x: x, y: y, width: titleW, height: titleH)
    }
    
    private func imageRectAtImagePositionTop(forContentRect contentRect: CGRect) -> CGRect {
        let imageSize = currentImageSize()
        let titleSize = titleSize ?? .zero
        
        let imageW = imageSize.width
        let imageH = imageSize.height
        let titleH = titleSize.height
        let totalH = imageH + titleH
        let totalHS = totalH + spacing
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        switch contentHorizontalAlignment {
        case .left, .leading:
            x = contentRect.minX
        case .right, .trailing:
            x = contentRect.maxX - imageW
        default:
            x = contentRect.midX - (imageW / 2.0)
        }
        
        switch contentVerticalAlignment {
        case .top:
            y = contentRect.minY
        case .bottom:
            y = contentRect.maxY - totalHS
        default:
            y = (contentRect.height - totalHS) / 2.0 + contentRect.minY
        }
        
        return CGRect(x: x, y: y, width: imageW, height: imageH)
    }
    
    private func titleRectAtImagePositionTop(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = imageRectAtImagePositionTop(forContentRect: contentRect)
        let titleSize = titleSize ?? .zero
        let titleW = titleSize.width
        let titleH = titleSize.height
        
        var x: CGFloat = 0
        let y: CGFloat = imageRect.maxY + spacing
        switch contentHorizontalAlignment {
        case .left, .leading:
            x = contentRect.minX
        case .right, .trailing:
            x = contentRect.maxX - titleW
        default:
            x = contentRect.midX - titleW / 2.0
        }
        return CGRect(x: x, y: y, width: titleW, height: titleH)
    }
    
    private func imageRectAtImagePositionBottom(forContentRect contentRect: CGRect) -> CGRect {
        let imageSize = currentImageSize()
        let titleSize = titleSize ?? .zero
        
        let imageW = imageSize.width
        let imageH = imageSize.height
        let titleH = titleSize.height
        let totalH = imageH + titleH
        let totalHS = totalH + spacing
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        switch contentHorizontalAlignment {
        case .left, .leading:
            x = contentRect.minX
        case .right, .trailing:
            x = contentRect.maxX - imageW
        default:
            x = contentRect.midX - (imageW / 2.0)
        }
        
        switch contentVerticalAlignment {
        case .top:
            y = titleH + spacing + contentRect.minY
        case .bottom:
            y = contentRect.maxY - imageH
        default:
            y = (contentRect.height - totalHS) / 2.0 + titleH + spacing + contentRect.minY
        }
        
        return CGRect(x: x, y: y, width: imageW, height: imageH)
    }
    
    private func titleRectAtImagePositionBottom(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = imageRectAtImagePositionBottom(forContentRect: contentRect)
        let titleSize = titleSize ?? .zero
        let titleW = titleSize.width
        let titleH = titleSize.height
        
        var x: CGFloat = 0
        let y: CGFloat = imageRect.minY - spacing - titleH
        switch contentHorizontalAlignment {
        case .left, .leading:
            x = contentRect.minX
        case .right, .trailing:
            x = contentRect.maxX - titleW
        default:
            x = contentRect.midX - titleW / 2.0
        }
        return CGRect(x: x, y: y, width: titleW, height: titleH)
    }
    
    /// 当前图片size
    /// - Returns: CGSize
    private func currentImageSize() -> CGSize {
        return currentImage?.size ?? CGSize.zero
    }
    
    private func currentTitleSize() -> CGSize {
        let text = currentTitle ?? ""
        let font = titleLabel?.font ?? UIFont.systemFont(ofSize: 17)
        return text.boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size
    }
    
    /// 水平方向的内边距宽度
    /// - Parameter inset: 内边距
    /// - Returns: 宽度
    func HorizontalValue(inset: UIEdgeInsets) -> CGFloat {
        return inset.left + inset.right
    }
    
    /// 垂直方向的内边距高度
    /// - Parameter inset: 内边距
    /// - Returns: 高度
    func VerticalValue(inset: UIEdgeInsets) -> CGFloat {
        return inset.top + inset.bottom
    }
    
}
