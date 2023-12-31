//
//  TabBarController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/30.
//

import UIKit

class TabBarController: TYBaseViewController {
    private let tabbarInfo = ["机型", "比例", "布局"]
    
    private lazy var tabbarView: TYBaseView = {
        let view = TYBaseView()
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var tabbarStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    override func addSubviews() {
        view.addSubview(tabbarView)
        tabbarView.addSubview(tabbarStackView)
        
        for tabbar in tabbarInfo {
            let btn = UIButton(type: .custom)
            btn.setTitle(tabbar, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            tabbarStackView.addArrangedSubview(btn)
        }
    }
    
    override func layoutConstraintWithSubViews() {
        // 计算tabbar距离底部的约束条件
        let bottomAnchor = -tabbarView.safeBottom - 10
        // 设置约束
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomAnchor),
            tabbarView.heightAnchor.constraint(equalToConstant: 44),
            
            tabbarStackView.leadingAnchor.constraint(equalTo: tabbarView.leadingAnchor, constant: 20),
            tabbarStackView.trailingAnchor.constraint(equalTo: tabbarView.trailingAnchor, constant: -20),
            tabbarStackView.topAnchor.constraint(equalTo: tabbarView.topAnchor),
            tabbarStackView.bottomAnchor.constraint(equalTo: tabbarView.bottomAnchor)
            
        ])
        
//        tabbarView.layoutMargins = UIEdgeInsets(top: 4, left: -20, bottom: 4, right: 20)
    }
}
