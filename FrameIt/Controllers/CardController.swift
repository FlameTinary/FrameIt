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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = 50.0
        return imageView
    }()
    
    // card
    private lazy var cardView: PhoneCard = {
        let view = PhoneCard(cardColor: .white)
//        view.layer.cornerRadius = 10.0
        return view
    }()
    
    override func addSubviews() {
        view.addSubview(wallpapterImageView)
        view.addSubview(cardView)
    }
    
    override func setupSubviews() {
        wallpapterImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(wallpapterImageView.snp.width).multipliedBy(1/proportion.toRadio())
        }
        cardView.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.height.equalTo(wallpapterImageView.snp.height)
//            make.width.equalTo(cardView.snp.height).multipliedBy(393 / 852)
            make.width.equalTo(wallpapterImageView.snp.height).multipliedBy(0.42)
            make.height.equalTo(cardView.snp.width).multipliedBy(2.17)
        }
    }
}
