//
//  PhoneCard.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/26.
//

import UIKit
import SnapKit

class PhoneCard: TYBaseView {
    // 时间
    // 中间灵动岛
    // 信号
    // wifi
    // 电池
    // 背景图片
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_111"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30.0
        return imageView
    }()
    // 底部横条
    // 左边底部手电筒
    // 右边底部相机
    
    override func setupSubviews() {
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
