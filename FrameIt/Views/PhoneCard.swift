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
        lbl.text = "13:14"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        lbl.textColor = cardColor == .white ? .white : .black
        return lbl
    }()
    // 中间灵动岛
    private lazy var island: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        return view
    }()
    // 信号
    private lazy var cellularView: UIImageView = {
        var imageName = "cellular"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        view.contentMode = .scaleAspectFit
        return view
    }()
    // wifi
    private lazy var wifiImageView: UIImageView = {
        var imageName = "wifi"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        view.contentMode = .scaleAspectFit
        return view
    }()
    // 电池
    private lazy var batteryImageView: UIImageView = {
        var imageName = "battery"
        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        view.contentMode = .scaleAspectFit
        return view
    }()
    // 背景图片
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_1"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
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
    private lazy var flashlightView: UIImageView = {
        var imageName = "flashlight"
//        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        view.contentMode = .scaleAspectFit
        return view
    }()
    // 右边底部相机
    private lazy var cameraView: UIImageView = {
        var imageName = "camera"
//        imageName = cardColor == .white ? imageName.appending("_white") : imageName.appending("_black")
        let view = UIImageView(image: UIImage(named: imageName))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
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
        addSubview(flashlightView)
        addSubview(cameraView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        island.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.26)
            make.height.equalTo(island.snp.width).multipliedBy(0.3)
        }
        leftLbl.snp.makeConstraints { make in
            make.centerY.equalTo(island)
//            make.left.equalToSuperview().offset(15)
            make.left.greaterThanOrEqualToSuperview().offset(10)
            make.right.equalTo(island.snp.left).offset(-15)
        }
        cellularView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(island.snp.right).offset(10)
            make.size.greaterThanOrEqualTo(CGSize(width: 1, height: 1))
        }
        wifiImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(cellularView.snp.right).offset(4)
//            make.size.equalTo(CGSize(width: 10, height: 7.2))
//            make.size.greaterThanOrEqualTo(CGSize(width: 5, height: 5))
            make.size.equalTo(cellularView)
        }
        batteryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(wifiImageView.snp.right).offset(4)
            make.right.equalToSuperview().offset(-20)
//            make.size.equalTo(CGSize(width: batteryW, height: batteryH))
//            make.size.equalTo(CGSize(width: 15, height: 15))
//            make.size.greaterThanOrEqualTo(CGSize(width: 5, height: 5))
            make.size.equalTo(cellularView).offset(4)
        }
        indicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(2)
        }
        flashlightView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        cameraView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        island.layer.cornerRadius = island.height / 2.0
        bgImageView.layer.cornerRadius = width / 4.0 / 2.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowRadius = width / 4.0 / 2.0
        layer.masksToBounds = false

    }
}
