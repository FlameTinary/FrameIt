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
    private lazy var leftLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "中国联通"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        return lbl
    }()
    // 中间灵动岛
    private lazy var island: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        return view
    }()
    // 信号
    private lazy var signalImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "personalhotspot"))
        return view
    }()
    // wifi
    private lazy var wifiImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "personalhotspot"))
        return view
    }()
    // 电池
    private lazy var batteryImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "personalhotspot"))
        return view
    }()
    // 背景图片
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_111"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20.0
        return imageView
    }()
    // 底部横条
    // 左边底部手电筒
    // 右边底部相机
    
    override func setupSubviews() {
        addSubview(bgImageView)
        addSubview(island)
        addSubview(leftLbl)
        addSubview(signalImageView)
        addSubview(wifiImageView)
        addSubview(batteryImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        island.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(16)
        }
        leftLbl.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(island.snp.left).offset(-10)
        }
        signalImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(island.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        wifiImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(signalImageView.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        batteryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(wifiImageView.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
    }
    
}
