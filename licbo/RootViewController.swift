//
//  RootViewController.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift

class RootViewController: BaseViewController {

    private var viewModel: RootViewModelType
    
    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 43.4643, longitude: -80.5204, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }()
    
    private lazy var userLocationPin: GMSMarker = {
        let point = GMSMarker()
        point.map = self.mapView
        point.title = "User Location"
        return point
    }()
    
    private lazy var storePins = [GMSMarker]()

    init(_ viewModel: RootViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(mapView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        mapView.padding = view.safeAreaInsets
    }
    
    func setup() {
        viewModel
            .userLocation
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (location) in
                if let location = location {
                    self?.userLocationPin.position = location
                    self?.mapView.animate(toLocation: location)
                }
            }).disposed(by: disposeBag)
        
        viewModel
            .stores
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (stores) in
                self?.udpateStorePins(stores)
            }).disposed(by: disposeBag)
        
    }
    
 func udpateStorePins(_ stores: [Store]) {
        // remove existing pins
        for pin in storePins {
            pin.map = nil
        }
        storePins = []
        for store in stores {
            guard let location = store.location else {
                continue
            }
            let point = GMSMarker.init(position: location)
            point.map = self.mapView
            point.title = store.name
            storePins.append(point)
        }
    }
}
