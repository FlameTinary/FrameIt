//
//  ProportionCell.swift
//  FrameIt
//
//  Created by Sheldon Tian on 2024/1/6.
//

import UIKit
import SnapKit

class ProportionCell: UICollectionViewCell {
    
    var proportion: TYProportion? {
        didSet {
            textLbl.text = proportion?.toName()
            updateConstraints()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var imageView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var textLbl: UILabel = {
        let view = UILabel()
        view.textColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        alpha = 0.4
        
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(textLbl)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLbl.translatesAutoresizingMaskIntoConstraints = false
        
        widthConstraint = imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        heightConstraint = imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        widthConstraint!.isActive = true
        heightConstraint!.isActive = true
        
        textLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 更新选中状态的UI
    private func updateSelectedState() {
        // 根据isSelected的值来更新UI，你可以在这里做一些自定义的UI更新
        if isSelected {
            // 选中状态
            print("选中状态")
            layer.borderWidth = 6.0
            layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            // 非选中状态
            print("非选中状态")
            layer.borderWidth = 0.0
            layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // 更新布局
    override func updateConstraints() {
        super.updateConstraints()
        guard let prop = proportion else { return }
        let radio = prop.toRadio()
        if prop.isLandscapeOrientation() { // 横向
            heightConstraint?.isActive = false
            heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/radio)
            heightConstraint!.isActive = true
        } else { // 纵向
            widthConstraint?.isActive = false
            widthConstraint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: radio)
            widthConstraint!.isActive = true
        }
        layoutIfNeeded()
    }
}
