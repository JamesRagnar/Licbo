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
        Observable
            .zip(viewModel.userLocation, viewModel.stores) { return($0, $1) }
            .subscribe(onNext: { [weak self] (userLocation, stores) in
//                self?.getDirections(from: userLocation, to: stores.first?.location)
            }).disposed(by: disposeBag)
    }
    
    func getDirections(from userLocation: CLLocationCoordinate2D?, to storeLocation: CLLocationCoordinate2D?) {
        guard let userLocation = userLocation, let storeLocation = storeLocation else {
            return
        }
        NetworkManager.getDirections(from: userLocation, to: storeLocation) {
            
        }
    }
    
// func udpateStorePins(_ stores: [Store]) {
//        // remove existing pins
//        for pin in storePins {
//            pin.map = nil
//        }
//        storePins = []
//        for store in stores {
//            guard let location = store.location else {
//                continue
//            }
//            let point = GMSMarker.init(position: location)
//            point.map = self.mapView
//            point.title = store.name
//            storePins.append(point)
//        }
//    }
}
