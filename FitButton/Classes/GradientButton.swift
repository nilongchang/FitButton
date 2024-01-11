//
//  GradientButton.swift
//  FitButton
//
//  Created by stargate5 on 2024/1/11.
//

import UIKit
import Foundation

open class GradientButton: FitButton {
    @IBInspectable open var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { updatePoints() }}
    @IBInspectable open var endPoint: CGPoint = CGPoint(x: 1, y: 1) { didSet { updatePoints() }}
    @IBInspectable open var startColor: UIColor = .white { didSet { updateColors() }}
    @IBInspectable open var endColor: UIColor = .white { didSet { updateColors() }}
    private var gradientLayer: CAGradientLayer?
    open var locations: [NSNumber] = [0.0,1.0] { didSet { updateLocation() } }
    open var disabledColors: [UIColor] = [UIColor.white,UIColor.white] { didSet { updateColors() }}
    
    // MARK: - Life Cycle ----------------------------
    public init(startPoint: CGPoint = CGPoint(x: 0, y: 0),
                endPoint: CGPoint = CGPoint(x: 1, y: 1),
                startColor: UIColor = UIColor.white,
                endColor: UIColor = UIColor.white) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.startColor = startColor
        self.endColor = endColor
        super.init(frame: .zero)
        self._initData()
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(UIButton.isEnabled))
    }
    
    // 从xib创建待验证
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self._initData()
    }
    
    private func _initData() {
        self.adjustsImageWhenHighlighted = false
        self.adjustsImageWhenDisabled = false
        addObserver(self, forKeyPath: #keyPath(UIButton.isEnabled), options: [.new, .old], context: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.isEmpty {
            return
        }
        updateUI()
    }
    
    func updatePoints() {
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
    }
    
    func updateColors() {
        if isEnabled {
            gradientLayer?.colors = [startColor,endColor].map{ $0.cgColor }
        }else {
            gradientLayer?.colors = disabledColors.map{ $0.cgColor }
        }
    }
    
    func updateLocation() {
        gradientLayer?.locations = locations
    }
    
    public func updateUI() {
        if let gradient = gradientLayer {
            gradient.removeFromSuperlayer()
        }
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        updateLocation()
        updateColors()
        updatePoints()
        if let gradientValue = gradientLayer {
            layer.insertSublayer(gradientValue, at: 0)
        }
    }
    
    // 监听属性变化的观察方法
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIButton.isEnabled), let _ = change?[.newKey] as? Bool {
            // 处理 isEnabled 属性变化的逻辑
            updateColors()
        }
    }
}

