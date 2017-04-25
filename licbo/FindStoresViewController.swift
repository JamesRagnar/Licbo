//
//  FindStoresViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit

class FindStoresViewController: UIViewController {

    private lazy var mapViewController: MapViewController = {
        let mapViewController = MapViewController(self.findStoresViewModel.mapViewModel)
        mapViewController.view.frame = self.view.bounds
        mapViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.findStoresViewModel.mapViewModel.setMapPadding(UIEdgeInsetsMake(0, 0, 40, 0))

        return mapViewController
    }()

    private lazy var menuViewController: FindStoresMenuViewController = {

        let menuViewController = FindStoresMenuViewController(self.findStoresViewModel.menuViewModel)
        menuViewController.view.frame = CGRect(x: 0,
                                               y: self.view.frame.height - 40,
                                               width: self.view.frame.width,
                                               height: 40)
        menuViewController.view.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]

        return menuViewController
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
        addChildViewController(mapViewController)
        view.addSubview(mapViewController.view)
        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
    }
}
