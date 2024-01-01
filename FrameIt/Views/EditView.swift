//
//  EditView.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/31.
//

import UIKit
import SnapKit

class EditView: TYBaseView {
    
    // 缩放系数
    var scale: CGFloat {
        didSet {
            cardView.scale = scale
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
    private lazy var cardView: PhoneCard = {
        let view = PhoneCard(scale: scale)
        return view
    }()
    
    // 下载功能
    
    init(proportion: TYProportion, scale: CGFloat = 0.6) {
        self.proportion = proportion
        self.scale = scale
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        addSubview(bgImageView)
        addSubview(cardView)
        bgImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.snp.remakeConstraints { [weak self] make in
            guard let weakself = self else { return }
            
            let phoneSize = TYDevice.iPhone15Pro.size()
            let phoneScale = phoneSize.width / phoneSize.height
            
            make.center.equalToSuperview()
            switch self?.proportion {
            case .oneToOne, .twoToOne, .fourToThree, .sixTeenToNine: // 横向
                make.top.equalToSuperview().offset(20 / weakself.scale)
                make.bottom.equalToSuperview().offset(-20 / weakself.scale)
                make.width.equalTo(weakself.cardView.snp.height).multipliedBy(phoneScale)
                
            case .fourToFive, .TwoToThree, .nineToSixTeen: // 纵向
                make.left.equalToSuperview().offset(60 / weakself.scale)
                make.right.equalToSuperview().offset(-60 / weakself.scale)
                make.height.equalTo(weakself.cardView.snp.width).dividedBy(phoneScale)
            default: break
            }
        }
    }
}
