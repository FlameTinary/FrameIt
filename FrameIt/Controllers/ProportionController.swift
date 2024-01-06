//
//  ProportionController.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2023/12/31.
//

import UIKit
import SnapKit

class ProportionController: TYBaseViewController {
    // cell id
    private let cellId = "proportionCellId"
    private let items: [TYProportion] = TYProportion.allCases
    // item margin
    private let margin: CGFloat = 8.0
    
    // 默认选中比例
    private var defaultProportion: TYProportion? {
        didSet {
            print("defaultProportion:\(String(describing: defaultProportion))")
        }
    }
    // 比例改变返回闭包
    var proportionDidChanged: ((TYProportion)->())
    
    // 九宫格
    private lazy var proportionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        view.register(ProportionCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()
    
    init(defaultProportion: TYProportion = .oneToOne, proportionDidChanged: @escaping (TYProportion) -> Void) {
        self.defaultProportion = defaultProportion
        self.proportionDidChanged = proportionDidChanged
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(proportionCollectionView)
        proportionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            proportionCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            proportionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            proportionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            proportionCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (index , item) in items.enumerated() {
            if item == defaultProportion {
                let indexPathToSelect = IndexPath(item: index, section: 0)
                self.proportionCollectionView.selectItem(at: indexPathToSelect, animated: true, scrollPosition: .top)
            }
        }
    }
    
}

extension ProportionController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProportionCell
        cell.proportion = items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        proportionDidChanged(items[indexPath.row])
        dismiss(animated: true)
    }
    
}

extension ProportionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 每行3个
        let lineCount: Int = 3
        let collectionViewW = view.width - margin * 2
        let itemW = (collectionViewW - CGFloat((lineCount - 1)) * margin) / CGFloat(lineCount)
        return CGSize(width: itemW, height: itemW)
    }
}
