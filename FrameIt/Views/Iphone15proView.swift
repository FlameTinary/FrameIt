//
//  Iphone15proView.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/25.
//

import UIKit
import SnapKit

class Iphone15proView: TYBaseView {
    // 该机型的宽高
    private let viewW = 393
    private let viewH = 852
    // 壳图片
    private var borderImage = UIImage(named: "iPhone_15_pro_Titanium_black")
    private lazy var borderImageView: UIImageView = {
        let imageView = UIImageView(image: borderImage)
        return imageView
    }()
    // 滚动视图
    private lazy var imageScrollView: TYImageScrollView = {
        let imageScrollView = TYImageScrollView(image: UIImage(named: "223"), cornerRadio: 40.0)
        return imageScrollView
    }()
    // 添加子视图
    // 布局子视图
    override func setupSubviews() {
        addSubview(imageScrollView)
        addSubview(borderImageView)
        
        imageScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        borderImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
