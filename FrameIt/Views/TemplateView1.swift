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
    
    // 缩放系数
    var scale: Float {
        didSet {
//            if let view = phoneView as? PhoneModelProtocol {
//                view.phoneScale = scale
//            }
            setNeedsLayout()
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
                addSubview(phoneView)
            }
            setNeedsLayout()
        }
    }
    
    init(proportion: TYProportion, scale: Float = 1.0, phoneViews: [TYBaseView]) {
        self.proportion = proportion
        self.scale = scale
        self.phoneViews = phoneViews
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        addSubview(bgImageView)
        for phoneView in phoneViews {
            addSubview(phoneView)
        }
        bgImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for phoneView in phoneViews {
            
            phoneView.snp.remakeConstraints { [weak self] make in
                guard let weakself = self else { return }
                guard let viewProtocol = phoneView as? PhoneModelProtocol else {return}
                make.center.equalToSuperview()
                switch self?.proportion {
                case .oneToOne, .twoToOne, .fourToThree, .sixTeenToNine: // 横向
                    make.height.equalToSuperview().multipliedBy(weakself.scale)
                    make.width.equalTo(phoneView.snp.height).multipliedBy(viewProtocol.whRatio)
                case .fourToFive, .TwoToThree, .nineToSixTeen: // 纵向
                    make.width.equalToSuperview().multipliedBy(weakself.scale)
                    make.height.equalTo(phoneView.snp.width).dividedBy(viewProtocol.whRatio)
                default: break
                }
            }
            
        }
        
    }
}
