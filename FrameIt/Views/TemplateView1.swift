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
            phoneView.phoneScale = scale
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
    var phoneView : PhoneModelProtocol {
        didSet {
            (oldValue as! TYBaseView).removeFromSuperview()
            addSubview((phoneView as! TYBaseView))
            setNeedsLayout()
        }
    }
    
    init(proportion: TYProportion, scale: Float = 1.0, phoneView: PhoneModelProtocol) {
        self.proportion = proportion
        self.scale = scale
        self.phoneView = phoneView
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        addSubview(bgImageView)
        addSubview((phoneView as! TYBaseView))
        bgImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let view = phoneView as! TYBaseView
        view.snp.remakeConstraints { [weak self] make in
            guard let weakself = self else { return }
            make.center.equalToSuperview()
            switch self?.proportion {
            case .oneToOne, .twoToOne, .fourToThree, .sixTeenToNine: // 横向
                make.height.equalToSuperview().multipliedBy(weakself.scale)
                make.width.equalTo(view.snp.height).multipliedBy(weakself.phoneView.whRatio)
            case .fourToFive, .TwoToThree, .nineToSixTeen: // 纵向
                make.width.equalToSuperview().multipliedBy(weakself.scale)
                make.height.equalTo(view.snp.width).dividedBy(weakself.phoneView.whRatio)
            default: break
            }
        }
    }
}
