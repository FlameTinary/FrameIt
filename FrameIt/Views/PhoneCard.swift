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
    var cardColor: CardColor
    
    // 缩放系数
    var scale: CGFloat
    
    // 时间
    private lazy var leftLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "13:14"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
    
    init(scale: CGFloat, cardColor: CardColor = .white) {
        self.cardColor = cardColor
        self.scale = scale
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
//        addSubview(flashlightView)
//        addSubview(cameraView)
        
//        let rightStack = UIStackView(arrangedSubviews: [cellularView, wifiImageView, batteryImageView])
//        let topStack = UIStackView(arrangedSubviews: [leftLbl, island])
//        
//        addSubview(topStack)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        flashlightView.snp.makeConstraints { make in
//            let viewW = 44 * scale
//            make.bottom.equalToSuperview().offset(-30 * scale)
//            make.left.equalToSuperview().offset(20 * scale)
//            make.size.equalTo(CGSize(width: viewW, height: viewW))
//        }
//        cameraView.snp.makeConstraints { make in
//            make.bottom.equalTo(flashlightView)
//            make.right.equalToSuperview().offset(-20 * scale)
//            make.size.equalTo(flashlightView)
//        }
//        indicatorView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-10 * scale)
//            make.width.equalToSuperview().multipliedBy(0.4)
//            make.height.equalTo(2)
//        }
//        topStack.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(44)
//            make.top.equalTo(10)
//        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        print("PhoneCard-layoutSubviews")
        island.layer.cornerRadius = island.height / 2.0
        bgImageView.layer.cornerRadius = width / 4.0 / 2.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowRadius = width / 4.0 / 2.0
        layer.masksToBounds = false

        island.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(0.028 * height)
            make.width.equalToSuperview().multipliedBy(0.26)
            make.height.equalTo(island.snp.width).multipliedBy(0.3)
        }
        leftLbl.snp.remakeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalToSuperview().offset(width * 0.121)
            make.right.equalTo(island.snp.left).offset(-0.091 * width)
        }
        cellularView.snp.remakeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(island.snp.right).offset(0.061 * width)
            make.size.greaterThanOrEqualTo(CGSize(width: 1, height: 1))
        }
        wifiImageView.snp.remakeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(cellularView.snp.right).offset(0.024 * width)
            make.size.equalTo(cellularView)
        }
        batteryImageView.snp.remakeConstraints { make in
            make.centerY.equalTo(island)
            make.left.equalTo(wifiImageView.snp.right).offset(0.024 * width)
            make.right.equalToSuperview().offset(-0.121 * width)
//            make.size.equalTo(cellularView).offset(0.024 * width)
            make.size.equalTo(cellularView).offset(0.024 * width)
        }
        indicatorView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-0.014 * height)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(2)
        }
//        flashlightView.snp.remakeConstraints { make in
//            make.bottom.equalToSuperview().offset(-0.056 * height)
//            make.left.equalToSuperview().offset(0.121 * width)
//            make.size.equalTo(CGSize(width: 0.121 * width, height: 0.121 * width))
//        }
//        cameraView.snp.remakeConstraints { make in
//            make.bottom.equalToSuperview().offset(-0.056 * height)
//            make.right.equalToSuperview().offset(-0.121 * width)
//            make.size.equalTo(CGSize(width: 0.121 * width, height: 0.121 * width))
//        }
////        layoutIfNeeded()
    }
}
