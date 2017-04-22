//
//  ProductDetailViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-22.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: BaseViewController {

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }()

    private lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }()

    private let product: Product

    init(_ product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(thumbnailImageView)
        view.addSubview(detailImageView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the high detail image view until it is loaded
        detailImageView.alpha = 0

        product
            .thumbnailObservable?
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (image) in
                self?.thumbnailImageView.image = image
        }).disposed(by: disposeBag)

        product
            .imageObservable?
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (image) in
                self?.detailImageView.image = image
                UIView.animate(withDuration: 0.3, animations: {
                    self?.detailImageView.alpha = image == nil ? 0 : 1
                })
            })
            .disposed(by: disposeBag)
        
    }
}
