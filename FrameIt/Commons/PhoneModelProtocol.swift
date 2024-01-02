//
//  PhoneModelProtocol.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/2.
//

import UIKit

@objc protocol PhoneModelProtocol {
    // 缩放系数
    var phoneScale: Float {get set}
    
    // 壳图片
    @objc optional var borderImage: UIImage {get}
    
    // 宽高比例
    var whRatio: Float {get}
    
}

extension PhoneModelProtocol where Self: TYBaseView {
    
}
