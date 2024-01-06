//
//  TabBarController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/30.
//

import UIKit
import SnapKit

class TabBarController: TYBaseViewController {
    
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
    private lazy var editView: TemplateView1 = {
        let view = TemplateView1(proportion: .oneToOne, scale: 0.6, phoneViews: [Iphone15proView(),Iphone15proView()])
        return view
    }()
    
    // 缩放滑块
    private lazy var scaleSlider: UISlider = {
        let view = UISlider()
        view.minimumValue = 0.4
        view.maximumValue = 0.6
        view.value = Float(editView.scale)
        view.addTarget(self, action: #selector(scaleSliderValueChanged), for: .valueChanged)
        return view
    }()
    
    // 旋转滑块
    private lazy var rotationSlider: UISlider = {
        let view = UISlider()
        view.minimumValue = -1.0
        view.maximumValue = 1.0
        view.value = Float(editView.rotation)
        view.addTarget(self, action: #selector(rotationSliderValueChanged), for: .valueChanged)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabbarView)
        tabbarView.addSubview(tabbarStackView)
        view.addSubview(editView)
        view.addSubview(scaleSlider)
        view.addSubview(rotationSlider)
        
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
        
        scaleSlider.snp.makeConstraints { make in
            make.bottom.equalTo(tabbarView.snp.top).offset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        rotationSlider.snp.makeConstraints { make in
            make.bottom.equalTo(scaleSlider.snp.top).offset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    // tabbar点击
    @objc func tabbarClick(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("点击了机型")
            let phoneViewController = PhoneViewController {[weak self] phoneViews in
                self?.editView.phoneViews = phoneViews
                self?.editView.rotation = self?.rotationSlider.value ?? 0.5
            }
            present(phoneViewController, animated: true)
        case 1:
            print("点击了比例")
            let proportionController = ProportionController(defaultProportion: self.editView.proportion) {[weak self] proportion in
                self?.editView.proportion = proportion
                self?.updateViewConstraints()
            }
            present(proportionController, animated: true)
        case 2:
            print("点击了模板")
        default:
            print("no action")
        }
    }
    
    // 缩放滑块变化
    @objc func scaleSliderValueChanged(sender: UISlider) {
//        print("\(sender.value)")
        editView.scale = sender.value
    }
    
    // 旋转滑块变化
    @objc func rotationSliderValueChanged(sender: UISlider) {
//        print("rotationSlider: \(sender.value)")
        editView.rotation = sender.value
    }
    
    override func updateViewConstraints() {
//        print("TabBarController-updateViewConstraints")
        super.updateViewConstraints()
        // 更新背景视图约束
        editView.snp.remakeConstraints { [weak self] make in
            guard let weakself = self else { return }
            
            switch self?.editView.proportion {
            case .oneToOne, .twoToOne, .fourToThree, .sixTeenToNine:
                make.center.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(weakself.editView.snp.width).dividedBy(weakself.editView.proportion.toRadio())
            case .fourToFive, .TwoToThree, .nineToSixTeen:
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(100)
                make.bottom.equalTo(weakself.tabbarView.snp.top).offset(-40)
                make.width.equalTo(weakself.editView.snp.height).multipliedBy(weakself.editView.proportion.toRadio())
            default: break
            }
        }
    }
}
