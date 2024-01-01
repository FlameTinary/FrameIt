//
//  TabBarController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/30.
//

import UIKit
import SnapKit

class TabBarController: TYBaseViewController {
    // 背景视图比例
    private var proportion: TYProportion = .oneToOne {
        didSet {
            editView.proportion = proportion
            updateViewConstraints()
        }
    }
    // tabbar数据
    private let tabbarInfo = ["机型", "比例", "模板"]
    
    // 底部tabbar栏
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
    
    // 背景视图
    private lazy var editView: EditView = {
        let view = EditView(proportion: proportion)
//        view.backgroundColor = .red
        return view
    }()
    
    private lazy var slider: UISlider = {
        let view = UISlider()
        view.minimumValue = 0.2
        view.value = Float(editView.scale)
        view.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return view
    }()
    
    // 设备视图
//    private lazy var cardView: PhoneCard = {
//        let view = PhoneCard(cardColor: .white)
//        return view
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabbarView)
        tabbarView.addSubview(tabbarStackView)
        view.addSubview(editView)
        view.addSubview(slider)
        
        // 添加tabbar按钮
        for (index, tabbar) in tabbarInfo.enumerated() {
            let btn = UIButton(type: .custom)
            btn.setTitle(tabbar, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.tag = index
            btn.addTarget(self, action: #selector(tabbarClick), for: .touchUpInside)
            tabbarStackView.addArrangedSubview(btn)
        }
        
        tabbarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-tabbarView.safeBottom - 10)
        }
        
        tabbarStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
        
        slider.snp.makeConstraints { make in
            make.bottom.equalTo(tabbarView.snp.top).offset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    // tabbar点击
    @objc func tabbarClick(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("点击了机型")
        case 1:
            print("点击了比例")
            let proportionController = ProportionController { [weak self] proportion in
                self?.proportion = proportion
            }
            present(proportionController, animated: true)
        case 2:
            print("点击了模板")
        default:
            print("no action")
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
//        print("\(sender.value)")
        editView.scale = CGFloat(sender.value)
    }
    
    override func updateViewConstraints() {
//        print("TabBarController-updateViewConstraints")
        super.updateViewConstraints()
        // 更新背景视图约束
        editView.snp.remakeConstraints { [weak self] make in
            guard let weakself = self else { return }
            
            switch self?.proportion {
            case .oneToOne, .twoToOne, .fourToThree, .sixTeenToNine:
                make.center.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(weakself.editView.snp.width).dividedBy(weakself.proportion.toRadio())
            case .fourToFive, .TwoToThree, .nineToSixTeen:
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(100)
                make.bottom.equalTo(weakself.tabbarView.snp.top).offset(-40)
                make.width.equalTo(weakself.editView.snp.height).multipliedBy(weakself.proportion.toRadio())
            default: break
            }
        }
    }
}
