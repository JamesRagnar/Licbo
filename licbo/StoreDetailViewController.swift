//
//  StoreDetailViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-22.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

class StoreDetailViewController: BaseViewController {

    private let store: Store

    init(_ store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .gray
        title = store.name()
    }
}
