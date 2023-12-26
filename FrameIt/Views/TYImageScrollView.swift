//
//  TYImageScrollView.swift
//  TYPictureMaker
//
//  Created by Sheldon Tian on 2023/5/18.
//

import UIKit

class TYImageScrollView : TYBaseView {
    
    private var shapeLayer : CAShapeLayer?
    
    // 源图
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // 设置圆角
    var cornerRadio : CGFloat {
        didSet {
            scrollView.layer.cornerRadius = cornerRadio
            scrollView.layer.masksToBounds = true
        }
    }
    
    // 滚动视图
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        addSubview(scrollView)
        return scrollView
    }()
    
    // 图像视图
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        scrollView.addSubview(imageView)
        return imageView
    }()
    
    init(image: UIImage?, cornerRadio: CGFloat) {
        self.cornerRadio = cornerRadio
        self.image = image
        super.init()
        self.backgroundColor = .clear
        self.imageView.image = image
        self.scrollView.layer.cornerRadius = cornerRadio
        self.scrollView.layer.masksToBounds = true
    }
    
    convenience init(image: UIImage?) {
        self.init(image: image, cornerRadio: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let img = image {
            scrollView.frame = bounds
            scrollView.contentSize = getContentViewSizeWith(image: img)
            imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
        }
        
    }
    
}


//MARK: 私有方法
private extension TYImageScrollView {
    // 通过图片的size得到视图的size
    private func getContentViewSizeWith(image:UIImage) -> CGSize {
        var scrollW = bounds.size.width + 1
        var scrollH = scrollW / image.size.width * image.size.height
        if (scrollH < bounds.size.height) {
            scrollH = bounds.size.height + 1
            scrollW = scrollH / image.size.height * image.size.width
        }
        return CGSize(width: scrollW, height: scrollH)
    }
}


//MARK: scrollview代理方法
extension TYImageScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


