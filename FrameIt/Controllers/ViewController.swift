//
//  ViewController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/25.
//

import UIKit
import SnapKit

class ViewController: TYBaseViewController {
    
    private lazy var imageView: Iphone15proView = {
        let imageView = Iphone15proView()
        return imageView
    }()

    override func addSubviews() {
        // 使用
        let iphone13ProView = iPhone13ProOutlineView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
//        view.addSubview(imageView)
        view.addSubview(iphone13ProView)
    }
    
//    override func setupSubviews() {
//        let imageW = 300
//        imageView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(CGSize(width: imageW, height: 852 / 393 * imageW))
//        }
//    }
}
