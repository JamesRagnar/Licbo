//
//  FindStoresMenuViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit

class FindStoresMenuViewController: BaseViewController {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
        label.autoresizingMask = [.flexibleWidth]
        label.text = "Find a Store"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleLabelTapped)))
        return label
    }()

    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 40, width: self.view.bounds.width, height: 40)
        return textField
    }()

    private var findStoresViewModel: FindStoresViewModelType

    init(_ findStoresViewModel: FindStoresViewModelType) {
        self.findStoresViewModel = findStoresViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = UIColor(white: 1, alpha: 0.75)

        view.addSubview(titleLabel)
        view.addSubview(textField)
    }

    @objc private func titleLabelTapped() {
        findStoresViewModel.menuLabelTapped()
    }
}
