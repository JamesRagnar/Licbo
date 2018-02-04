//
//  ProductCollectionViewCell.swift
//  licbo
//
//  Created by James Harquail on 2018-02-03.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    fileprivate lazy var disposeBag = DisposeBag()

    public var imageCache: ImageManager?

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()

        imageView.image = nil
        label.text = nil
    }
}

extension ProductCollectionViewCell: ViewModelBindableType {

    typealias ViewModelType = ProductModelType

    func bind(_ viewModel: ViewModelType) {

        viewModel
            .name
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)

        viewModel
            .imageURL
            .flatMap { [weak self] (urlString) -> Observable<UIImage?> in
                return self?.imageCache?.observable(for: urlString) ?? Observable.empty()
            }.bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
