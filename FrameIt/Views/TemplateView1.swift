//
//  TemplateView1.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/31.
//

import UIKit
import SnapKit

enum PhoneType {
case whiteCard, blackCard, iphone15Pro
}

class TemplateView1: TYBaseView {
    
    private let stackSpace = 10
    private let isSymmetry = false
    
    // 缩放系数
    var scale: Float {
        didSet {
//            if let view = phoneView as? PhoneModelProtocol {
//                view.phoneScale = scale
//            }
            setNeedsLayout()
        }
    }
    
    // 旋转系数
    var rotation: Float {
        didSet {
            updateZRotation()
        }
    }
    
    // 背景视图比例
    var proportion: TYProportion = .oneToOne
    
    // 背景视图
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_112"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 机型视图
    var phoneViews : [TYBaseView] {
        didSet {
            for oldView in oldValue {
                oldView.removeFromSuperview()
            }
            for phoneView in phoneViews {
                phoneStack.addArrangedSubview(phoneView)
            }
            setNeedsLayout()
        }
    }
    
    private lazy var phoneStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = CGFloat(stackSpace)
        return stack
    }()
    
    init(proportion: TYProportion, scale: Float = 1.0, rotation: Float = 0, phoneViews: [TYBaseView]) {
        self.proportion = proportion
        self.scale = scale
        self.rotation = rotation
        self.phoneViews = phoneViews
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        addSubview(bgImageView)
        addSubview(phoneStack)
        for phoneView in phoneViews {
            phoneStack.addArrangedSubview(phoneView)
        }
        updateZRotation()
        bgImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 计算phoneStack的长宽
        var stackSize : CGSize = CGSizeZero
        let phoneView = phoneViews.first as! any PhoneModelProtocol
        // 根据机型个数计算space的长度
        let space = stackSpace * (phoneViews.count - 1)
        
        if (proportion.isLandscapeOrientation()) {
            // 横向
            stackSize.height = height * CGFloat(scale)
            
            // 获取单个机型视图的宽
            let phoneW = CGFloat(phoneView.whRatio) * stackSize.height
            
            // 根据机型个数计算所有机型的总宽
            let phonesW = phoneW * CGFloat(phoneViews.count)
            
            // 计算stack的宽
            stackSize.width = phonesW + CGFloat(space)
        } else {
            // 纵向
            stackSize.width = width * CGFloat(scale)
            
            // 计算所有机型视图的总宽
            let phonesW = stackSize.width - CGFloat(space)
            
            // 根据机型个数计算单个机型的宽
            let phonew = phonesW / CGFloat(phoneViews.count)
            
            // 根据机型的宽高比，计算单个机型的高度
            let phoneH = phonew / CGFloat(phoneView.whRatio)
            stackSize.height = phoneH
            
        }
        
        phoneStack.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(stackSize)
        }
        
//        for phoneView in phoneViews {
//            
//            phoneView.snp.remakeConstraints { [weak self] make in
//                guard let weakself = self else { return }
//                guard let viewProtocol = phoneView as? PhoneModelProtocol else {return}
//                make.center.equalToSuperview()
//                switch self?.proportion {
//                case .oneToOne, .twoToOne, .fourToThree, .sixTeenToNine: // 横向
//                    make.height.equalToSuperview().multipliedBy(weakself.scale)
//                    make.width.equalTo(phoneView.snp.height).multipliedBy(viewProtocol.whRatio)
//                case .fourToFive, .TwoToThree, .nineToSixTeen: // 纵向
//                    make.width.equalToSuperview().multipliedBy(weakself.scale)
//                    make.height.equalTo(phoneView.snp.width).dividedBy(viewProtocol.whRatio)
//                default: break
//                }
//            }
//            
//        }
        
    }
    
    private func updateZRotation() {
        
        // 计算弧度
        let radian : CGFloat = CGFloat(10.0 * rotation)
        let rotationAngle = CGFloat(radian * .pi / 180.0)  // 将角度转换为弧度
        
        for (index, phoneView) in phoneViews.enumerated() {
            if (isSymmetry) {
                phoneView.transform = CGAffineTransform(rotationAngle: index % 2 == 0 ? -rotationAngle : rotationAngle)
            } else {
                phoneView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            }
        }
    }
}
