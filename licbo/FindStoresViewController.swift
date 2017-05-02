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
                                               height: self.view.frame.height)
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

        Observable
            .combineLatest(findStoresViewModel.viewState, BaseViewController.keyboardObserver())
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (state, keyboard) in
                self?.layoutSubviews(state, keyboard: keyboard)
        }).disposed(by: disposeBag)
    }

    private func layoutSubviews(_ state: FindStoresViewControllerState, keyboard: KeyboardUpdateTuple) {
        var menuFrame = CGRect.zero
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        switch state {
        case .base:
            menuViewController.textField.resignFirstResponder()
            menuFrame = CGRect(x: 0, y: viewHeight - 40, width: viewWidth, height: viewHeight)
        case .search:
            menuViewController.textField.becomeFirstResponder()
            menuFrame = CGRect(x: 0, y: 64, width: viewWidth, height: viewHeight - 64 - keyboard.height)
        }
        UIView.animate(withDuration: keyboard.animationDuration == 0 ? 0.3 : keyboard.animationDuration,
                       delay: 0,
                       options: keyboard.animationCurve,
                       animations: { [weak self] in
            self?.menuViewController.view.frame = menuFrame
        }, completion: nil)
    }
}



