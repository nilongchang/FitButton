//
//  ViewController.swift
//  FitButton
//
//  Created by 倪龙昌 on 03/31/2023.
//  Copyright (c) 2023 倪龙昌. All rights reserved.
//

import UIKit
import FitButton
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = FitButton(type: .custom)
        // 设置图片和文字的间距
        button.spacing = 10
        // 设置图片位置
        button.imagePosition = .bottom
        // 设置图片大小
        button.imageSize = CGSize(width: 40, height: 40)
        // 设置内边距(非必须)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 正常UIButton的设置
        button.setTitle("FitButton", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(named: "read"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor

        view.addSubview(button)
        
        //        button.sizeToFit()
        //        button.frame.origin = CGPoint(x: 100, y: 100)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
//            $0.width.height.equalTo(100)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

