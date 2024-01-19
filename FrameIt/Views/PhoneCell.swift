//
//  PhoneCell.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/11.
//

import UIKit

class PhoneCell: UITableViewCell {
    
    // cell id
    private let cellId = "choosePhoneCellId"
    
    private let cellSpace: CGFloat = 10
    
    // 需要显示类型
    var deviceModel: DeviceModel? {
        didSet {
            print(deviceModel ?? "")
        }
    }
    
    private lazy var leftView: UIView = {
        let view = UIView()
        let phone = Iphone15proView()
        view.addSubview(phone)
        phone.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(phone.snp.width).dividedBy(phone.whRatio)
        }
        return view
    }()
    
    private lazy var rightView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellSpace
        layout.minimumInteritemSpacing = cellSpace
        layout.itemSize = CGSize(width: 100, height: 100)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.register(ChoosePhoneCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leftView)
        contentView.addSubview(rightView)
        
        leftView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.top.left.bottom.equalToSuperview()
//            make.right.equalTo(rightView.snp.left)
        }
        
        rightView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(leftView.snp.right).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhoneCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deviceModel?.colors.count ?? 0
//        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
 
}

extension PhoneCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("collectionView-inside: \(collectionView.width)")
        print("cell-inside: \(width)")
        let itemW = (collectionView.width - cellSpace * 2) / 3
        return CGSize(width: itemW, height: itemW)
    }
}
