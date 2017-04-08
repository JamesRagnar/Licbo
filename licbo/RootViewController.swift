//
//  RootViewController.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit

class RootViewController: BaseViewController {
    
    private lazy var navController: UINavigationController = {
        let navController = UINavigationController(rootViewController: DashboardViewController())
        return navController
    }()
    
    override func loadView() {
        super.loadView()
        addChildViewController(navController)
        view.addSubview(navController.view)
    }
}
