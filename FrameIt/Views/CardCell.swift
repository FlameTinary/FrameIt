//
//  CardCell.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/12.
//

import UIKit

class CardCell : UITableViewCell {
    // 需要显示类型
    var deviceModel: DeviceModel? {
        didSet {
            print(deviceModel ?? "")
        }
    }
    
    private lazy var whiteView: ChoosePhoneView = {
        let view = ChoosePhoneView()
        let card = PhoneCard(scale: 0.6, cardColor: .white)
        view.addSubview(card)
        card.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(card.snp.width).dividedBy(card.whRatio)
        }
        return view
    }()
    
    private lazy var blackView: ChoosePhoneView = {
//        let view = PhoneCard(scale: 0.3, cardColor: .black)
        let view = ChoosePhoneView()
        let card = PhoneCard(scale: 0.6, cardColor: .black)
        view.addSubview(card)
        card.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(card.snp.width).dividedBy(card.whRatio)
        }
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(whiteView)
        contentView.addSubview(blackView)
        
        whiteView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
//            make.right.equalTo(rightView.snp.left)
            make.width.equalTo(whiteView.snp.height)
        }
        
        blackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(whiteView.snp.right).offset(10)
            make.width.equalTo(whiteView.snp.width)

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
