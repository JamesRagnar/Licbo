//
//  BaseCollectionViewCell.swift
//  licbo
//
//  Created by James Harquail on 2017-04-22.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {

    lazy var disposeBag = CompositeDisposable()

    override func prepareForReuse() {
        disposeBag.dispose()
        super.prepareForReuse()
    }
}
