//
//  BaseViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-08.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    open lazy var disposeBag = DisposeBag()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
