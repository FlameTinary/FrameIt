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
    
    // cell id
    private let cellId = "phoneCellId"
    private let cardCellId = "cardCellId"
    
    // 数据模型
    private var deviceCategories: [DeviceCategory]?
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self

        return view
    }()
    
//    private lazy var btn1: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("白色卡片", for: .normal)
//        btn.tag = 0
//        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
//        return btn
//    }()
//    
//    private lazy var btn2: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("黑色卡片", for: .normal)
//        btn.tag = 1
//        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
//        return btn
//    }()
//    
//    private lazy var btn3: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("iPhone 15 pro", for: .normal)
//        btn.tag = 2
//        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
//        return btn
//    }()
    
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
        
        // 获取数据
        // 获取 JSON 文件路径
        if let path = Bundle.main.path(forResource: "devices", ofType: "json") {
            do {
                // 读取文件内容
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                // 解析 JSON 数据
                deviceCategories = try JSONDecoder().decode([DeviceCategory].self, from: jsonData)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        // 打印解析结果
        if let dc = deviceCategories {
            for category in dc {
                print("Header: \(category.header)")
                for model in category.models {
                    print("  - Device: \(model.device), ID: \(model.id)")
                    for color in model.colors {
                        print("    - Color: \(color.color)")
                    }
                }
            }
        }
        
        
        // 布局子视图
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        }
//        view.addSubview(btn1)
//        view.addSubview(btn2)
//        view.addSubview(btn3)
//        btn1.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.left.equalToSuperview().offset(100)
//            make.size.equalTo(CGSize(width: 100, height: 44))
//        }
//        
//        btn2.snp.makeConstraints { make in
//            make.top.equalTo(btn1.snp.bottom).offset(20)
//            make.left.equalTo(btn1)
//            make.size.equalTo(btn1)
//        }
//        btn3.snp.makeConstraints { make in
//            make.top.equalTo(btn2.snp.bottom).offset(20)
//            make.left.equalTo(btn1)
//            make.size.equalTo(btn1)
//        }
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

extension PhoneViewController: UITableViewDelegate, UITableViewDataSource {
    
    // section number
    func numberOfSections(in tableView: UITableView) -> Int {
        return deviceCategories?.count ?? 0
    }
    
    // row number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = deviceCategories?[section]
        return category?.models.count ?? 0
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = deviceCategories?[indexPath.section]
        let model = category?.models[indexPath.row]
        if indexPath.section == 0 { // card
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cardCellId) as? CardCell else {
                let cell = CardCell(style: .default, reuseIdentifier: cardCellId)
                cell.deviceModel = model
                return cell
            }
            cell.deviceModel = model
            return cell
        } else { // phone
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PhoneCell else {
                let cell = PhoneCell(style: .default, reuseIdentifier: cellId)
                cell.deviceModel = model
                return cell
            }
            cell.deviceModel = model
            return cell
        }
    }
    
    // header 视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let category = deviceCategories?[section] {
            let headerView = UIView()
            headerView.backgroundColor = .white
            let header = UILabel()
            header.text = category.header
            headerView.addSubview(header)
            header.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(10)
            }
            return headerView
        }
        return nil
    }
    
    // header 高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // footer 高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    // row 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {return 150}
        // cell里面的collectionview的宽度系数为0.7
        let cellCollectionW = tableView.width * 0.7 - 20
        print("collectionView-outside: \(cellCollectionW)")
        print("cell-outside: \(tableView.width)")
        let cellCollectionItemW = (cellCollectionW - 20) / 3
        // 计算行数
        let category = deviceCategories?[indexPath.section]
        let model = category?.models[indexPath.row]
        let hang = ceil(Double((model?.colors.count ?? 0)) / 3.0)
        let height = (hang * cellCollectionItemW) + ((hang - 1) * 10)
        return height + 20
    }
}
