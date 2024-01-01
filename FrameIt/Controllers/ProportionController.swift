//
//  ProportionController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/31.
//

import UIKit
import SnapKit

class ProportionController: TYBaseViewController {
    
    // 比例改变返回闭包
    var proportionDidChanged: ((TYProportion)->())
    
    private lazy var btn1: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("1:1", for: .normal)
        btn.tag = 0
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btn2: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("16:9", for: .normal)
        btn.tag = 1
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var btn3: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("9:16", for: .normal)
        btn.tag = 2
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    init(proportionDidChanged: @escaping (TYProportion) -> Void) {
        self.proportionDidChanged = proportionDidChanged
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
        switch sender.tag {
        case 0: // 1:1
            proportionDidChanged(.oneToOne)
        case 1: // 16:9
            proportionDidChanged(.sixTeenToNine)
        case 2: // 9:16
            proportionDidChanged(.nineToSixTeen)
        default:
            proportionDidChanged(.oneToOne)
        }
        dismiss(animated: true)
    }
}
