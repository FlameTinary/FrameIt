//
//  CardController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/26.
//

import UIKit
import SnapKit

class CardController: TYBaseViewController {
    // 背景图片
    private lazy var wallpapterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wallpaper_112"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 50.0
        return imageView
    }()
    
    // card
    private lazy var cardView: PhoneCard = {
        let view = PhoneCard(cardColor: .white)
//        view.layer.cornerRadius = 10.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 8
        view.layer.masksToBounds = false
        return view
    }()
    
    override func addSubviews() {
        view.addSubview(wallpapterImageView)
        view.addSubview(cardView)
    }
    
    override func setupSubviews() {
        wallpapterImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(wallpapterImageView.snp.width)
        }
        cardView.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.height.equalTo(wallpapterImageView.snp.height)
//            make.width.equalTo(cardView.snp.height).multipliedBy(393 / 852)
            make.width.equalTo(wallpapterImageView.snp.height).multipliedBy(0.46)
            make.height.equalTo(wallpapterImageView.snp.height).offset(-20)
        }
    }
}
