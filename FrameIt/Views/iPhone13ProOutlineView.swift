//
//  iPhone13ProOutlineView.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/25.
//

import UIKit

class iPhone13ProOutlineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        // iPhone 13 Pro 外框的尺寸和位置
        let outlineRect = CGRect(x: 20, y: 100, width: 335, height: 700)

        // 外框颜色
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(2.0)

        // 绘制外框
        context.addRect(outlineRect)
        context.strokePath()

        // 绘制摄像头
        let cameraRect = CGRect(x: outlineRect.origin.x + 140, y: outlineRect.origin.y + 30, width: 60, height: 30)
        context.addRect(cameraRect)
        context.strokePath()

        // 绘制屏幕
        let screenRect = CGRect(x: outlineRect.origin.x + 20, y: outlineRect.origin.y + 30, width: outlineRect.width - 40, height: outlineRect.height - 60)
        context.addRect(screenRect)
        context.strokePath()
    }
}

