//
//  RootViewController.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: BaseViewController {

    private lazy var navController: UINavigationController = {
        let navController = UINavigationController()
        return navController
    }()

    private var viewModel: RootViewModelType

    init(_ viewModel: RootViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        addChildViewController(navController)
        view.addSubview(navController.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel
            .state
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (state) in
                self?.setViewControllerState(state)
            }).disposed(by: disposeBag)
    }

    private func setViewControllerState(_ state: RootViewControllerState) {
        switch state {
        case .dashboard:
            navController.viewControllers = [DashboardViewController()]
        }
    }
}
