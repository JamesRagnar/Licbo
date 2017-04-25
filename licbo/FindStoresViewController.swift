//
//  FindStoresViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import RxSwift

class FindStoresViewController: BaseViewController {

    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.frame = self.view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }()

    private lazy var menuViewController: FindStoresMenuViewController = {
        let menuViewController = FindStoresMenuViewController(self.findStoresViewModel)
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

        view.addSubview(mapView)

        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        findStoresViewModel
            .viewState
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (state) in
                self?.layoutSubviews(state)
        }).disposed(by: disposeBag)
    }

    private func layoutSubviews(_ state: FindStoresViewControllerState) {
        var menuFrame = CGRect.zero
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        switch state {
        case .base:
            menuFrame = CGRect(x: 0, y: viewHeight - 40, width: viewWidth, height: viewHeight)
        case .search:
            menuFrame = CGRect(x: 0, y: 64, width: viewWidth, height: viewHeight)
        }
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.menuViewController.view.frame = menuFrame
        }
    }
}
