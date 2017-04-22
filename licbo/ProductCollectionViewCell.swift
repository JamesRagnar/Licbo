//
//  ProductCollectionViewCell.swift
//  licbo
//
//  Created by James Harquail on 2017-04-22.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: BaseCollectionViewCell {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0,
                             y: self.contentView.bounds.height - 40,
                             width: self.contentView.bounds.width,
                             height: 40)
        label.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .center
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.contentView.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        addSubview(imageView)
        addSubview(textLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with product: Product) {
        textLabel.text = product.name
        if let disposable = product.thumbnailObservable?.bindTo(imageView.rx.image) {
            _ = disposeBag.insert(disposable)
        }
    }
}
