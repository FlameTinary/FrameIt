//
//  PhoneCard.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/26.
//

import UIKit
import SnapKit

enum CardColor {
    
    case white, black
}

class PhoneCard: TYBaseView {
    
    // 卡片颜色
    var cardColor: CardColor = .white
    
    // 时间
    private lazy var leftLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "中国联通"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = cardColor == .white ? .white : .black
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
    private lazy var cellularView: UIImageView = {
        var imageName = "cellular"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        return view
    }()
    // wifi
    private lazy var wifiImageView: UIImageView = {
        var imageName = "wifi"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        return view
    }()
    // 电池
    private lazy var batteryImageView: UIImageView = {
        var imageName = "battery"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        return view
    }()
    // 背景图片
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_1"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20.0
        return imageView
    }()
    // 底部横条
    private lazy var indicatorView: UIImageView = {
        var imageName = "indicator"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        return view
    }()
    // 左边底部手电筒
    // 右边底部相机
    
    
    init(cardColor: CardColor = .white) {
        self.cardColor = cardColor
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        addSubview(bgImageView)
        addSubview(island)
        addSubview(leftLbl)
        addSubview(cellularView)
        addSubview(wifiImageView)
        addSubview(batteryImageView)
        addSubview(indicatorView)
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
        cellularView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(island.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 10, height: 6.5))
        }
        wifiImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(cellularView.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 10, height: 7.2))
        }
        batteryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(wifiImageView.snp.right).offset(4)
            make.size.equalTo(CGSize(width: 10, height: 4.64))
        }
        indicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(2)
        }
    }
    
}
