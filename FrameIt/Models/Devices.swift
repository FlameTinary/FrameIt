//
//  Devices.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/11.
//

import Foundation

// 每个类型下面设备种类
struct DeviceModel: Codable {
    let id: String
    let device: String
    let colors: [DeviceColor]
}

// 设备颜色
struct DeviceColor: Codable {
    let color: String
}

// 设备类型
struct DeviceCategory: Codable {
    let header: String
    let models: [DeviceModel]
}
