//
//  CardController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/26.
//

import UIKit
import SnapKit

class CardController: TYBaseViewController {
    
    // 视图比例
    private let proportion : TYProportion = .nineToSixTeen
    
    // 背景图片
    private lazy var wallpapterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_112"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // card
    private lazy var cardView: PhoneCard = {
        let view = PhoneCard(scale: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wallpapterImageView)
        view.addSubview(cardView)
        
        // 获取iPhone 15 pro 机型尺寸
        let phoneSize = TYDevice.iPhone15Pro.size()
        // 计算宽高比
        let ratio = phoneSize.height / phoneSize.width
        
        // 布局
        NSLayoutConstraint.activate([
            wallpapterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wallpapterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wallpapterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            wallpapterImageView.heightAnchor.constraint(equalTo: wallpapterImageView.widthAnchor, multiplier: 1 / proportion.toRadio()),
            
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: wallpapterImageView.heightAnchor, multiplier: 0.42),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: ratio)
            
        ])
    }
    
}
