//
//  PhoneViewController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/1.
//

import UIKit

class PhoneViewController: TYBaseViewController {
    
    // 选中机型的个数
    private var modelNum: Int
    
    // 机型改变返回闭包
    var phoneViewDidChanged: (([TYBaseView])->())
    
    private lazy var btn1: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("白色卡片", for: .normal)
        btn.tag = 0
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btn2: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("黑色卡片", for: .normal)
        btn.tag = 1
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btn3: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("iPhone 15 pro", for: .normal)
        btn.tag = 2
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    init(modelNum:Int = 1, phoneViewDidChanged: @escaping ([TYBaseView]) -> Void) {
        self.modelNum = modelNum
        self.phoneViewDidChanged = phoneViewDidChanged
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        btn1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 100, height: 44))
        }
        
        btn2.snp.makeConstraints { make in
            make.top.equalTo(btn1.snp.bottom).offset(20)
            make.left.equalTo(btn1)
            make.size.equalTo(btn1)
        }
        btn3.snp.makeConstraints { make in
            make.top.equalTo(btn2.snp.bottom).offset(20)
            make.left.equalTo(btn1)
            make.size.equalTo(btn1)
        }
    }
    
    @objc func btnClick(sender: UIButton) {
        
        var modelArr:[TYBaseView] = []
        
        switch sender.tag {
        case 0: // whiteCard
            for _ in 0...modelNum {
                modelArr.append(PhoneCard(scale: 1.0, cardColor: .white))
            }
        case 1: // blackCard
            for _ in 0...modelNum {
                modelArr.append(PhoneCard(scale: 1.0, cardColor: .black))
            }
        case 2: // iphone15Pro
            for _ in 0...modelNum {
                modelArr.append(Iphone15proView())
            }
        default:
            for _ in 0...modelNum {
                modelArr.append(PhoneCard(scale: 1.0, cardColor: .white))
            }
        }
        phoneViewDidChanged(modelArr)
        dismiss(animated: true)
    }
}
