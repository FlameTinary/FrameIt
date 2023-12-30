//
//  TYDevice.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/29.
//

import Foundation

enum TYDevice {
    case iPhone4, iPhone4s, iPhone5, iPhone5c, iPhone5s, iPhone6, iPhone6plus, iPhone6s, iPhone6sPlus, iPhoneSE, iPhone7, iPhone7plus, iPhone8, iPhone8plus, iPhoneX, iPhoneXS, iPhoneXSMax, iPhoneXR, iPhone11, iPhone11Pro, iPhone11ProMax, iPhoneSE2, iPhone12Mini, iPhone12, iPhone12Pro, iPhone12ProMax, iPhone13Mini, iPhone13, iPhone13Pro, iPhone13ProMax, iPhoneSE3, iPhone14, iPhone14Plus, iPhone14Pro, iPhone14ProMax, iPhone15, iPhone15Plus, iPhone15Pro, iPhone15ProMax
    
    // 设备dpi
    func dpi() -> CGFloat {
        switch self {
            
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhone6, .iPhone6s, .iPhoneSE, .iPhone7, .iPhone8, .iPhoneXR, .iPhone11, .iPhoneSE2, .iPhoneSE3:
            return 326

        case .iPhone6plus, .iPhone6sPlus, .iPhone7plus, .iPhone8plus:
            return 401

        case .iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhone11Pro, .iPhone11ProMax, .iPhone12ProMax, .iPhone13ProMax, .iPhone14Plus:
            return 458

        case .iPhone12Mini, .iPhone13Mini:
            return 476
        case .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro, .iPhone14, .iPhone14Pro, .iPhone14ProMax, .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax:
            return 460
        }
    }
    
    // 设备尺寸
    func size() -> CGSize {
        switch self {
            
        case .iPhone4, .iPhone4s:
            return CGSize(width: 640, height: 960)

        case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE:
            return CGSize(width: 640, height: 1136)

        case .iPhone6, .iPhone6s, .iPhone7, .iPhone8, .iPhoneSE2, .iPhoneSE3:
            return CGSize(width: 750, height: 1334)
            
        case .iPhone6plus, .iPhone6sPlus, .iPhone7plus, .iPhone8plus:
            return CGSize(width: 1080, height: 1920)
        
        case .iPhoneX, .iPhoneXS, .iPhone11Pro:
            return CGSize(width: 1125, height: 2436)

        case .iPhoneXSMax, .iPhone11ProMax:
            return CGSize(width: 1242, height: 2688)
            
        case .iPhoneXR, .iPhone11:
            return CGSize(width: 828, height: 1792)

        case .iPhone12Mini, .iPhone13Mini:
            return CGSize(width: 1080, height: 2340)
            
        case .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro, .iPhone14:
            return CGSize(width: 1170, height: 2532)

        case .iPhone12ProMax, .iPhone13ProMax, .iPhone14Plus:
            return CGSize(width: 1284, height: 2778)

        case .iPhone14Pro, .iPhone15, .iPhone15Pro:
            return CGSize(width: 1179, height: 2556)
            
        case .iPhone14ProMax, .iPhone15Plus, .iPhone15ProMax:
            return CGSize(width: 1290, height: 2796)

        }
    }
}
