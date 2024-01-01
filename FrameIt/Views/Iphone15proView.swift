//
//  Iphone15proView.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/25.
//

import UIKit
import SnapKit

class Iphone15proView: TYBaseView {
    // 缩放系数
    var scale: CGFloat {
        didSet {
            imageScrollView.cornerRadio = 20.0 * scale
        }
    }
    
    // 壳图片
    private var borderImage = UIImage(named: "iPhone_15_pro_Titanium_black")
    private lazy var borderImageView: UIImageView = {
        let imageView = UIImageView(image: borderImage)
        return imageView
    }()
    // 滚动视图
    private lazy var imageScrollView: TYImageScrollView = {
        let imageScrollView = TYImageScrollView(image: UIImage(named: "wallpaper_1"), cornerRadio: 20.0)
//        imageScrollView.isHidden = true
        return imageScrollView
    }()
    
    init(scale: CGFloat = 1.0) {
        self.scale = scale
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 添加子视图
    // 布局子视图
    override func setupSubviews() {
        addSubview(imageScrollView)
        addSubview(borderImageView)
        
        imageScrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.89)
            make.height.equalToSuperview().multipliedBy(0.92)
        }
        
        borderImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
