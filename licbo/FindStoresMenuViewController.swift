//
//  FindStoresMenuViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit

class FindStoresMenuViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
        label.autoresizingMask = [.flexibleWidth]
        label.text = "Find a Store"
        return label
    }()

    private var findStoresMenuViewModel: FindStoresMenuViewModelType

    init(_ findStoresMenuViewModel: FindStoresMenuViewModelType) {
        self.findStoresMenuViewModel = findStoresMenuViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = UIColor(white: 1, alpha: 0.75)

        view.addSubview(titleLabel)
    }
}
