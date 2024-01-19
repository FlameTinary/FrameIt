//
//  ChoosePhoneCell.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/12.
//

import UIKit

class ChoosePhoneCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
