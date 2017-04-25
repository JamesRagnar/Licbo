//
//  MapViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import GoogleMaps
import RxSwift
import RxCocoa

class MapViewController: BaseViewController {

    private var mapViewModel: MapViewModelType

    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }()

    init(_ mapViewModel: MapViewModelType) {
        self.mapViewModel = mapViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(mapView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapViewModel
            .edgeInsets
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (insets) in
                self?.mapView.padding = insets
        }).disposed(by: disposeBag)

        mapViewModel.fetchStores()
    }
}
