//
//  MapViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class MapViewController: BaseViewController {

    private lazy var mapViewModel = MapViewModel()

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.frame)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(mapView)
    }

    private var userLocationPin: MKPointAnnotation?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true

        let userLocationObserver =
            mapView
                .rx
                .didUpdateUserLocation

        let storePinsObserver = mapViewModel.storePins

        Observable.combineLatest(userLocationObserver, storePinsObserver) {
            return ($0, $1)
        }.subscribe(onNext: { [weak self] (location, storePins) in
            print("Zup")
            self?.updateMapPins(location, storePins: storePins)
        }).addDisposableTo(disposeBag)

        mapView
            .rx
            .didSelectAnnotationView
            .subscribe(onNext: { (_) in
                
        }).disposed(by: disposeBag)

        mapViewModel.fetchStores()
    }

    private func updateMapPins(_ userlocation: MKUserLocation?, storePins: [MKPointAnnotation]?) {
        if let storePins = storePins {
            mapView.addAnnotations(storePins)
            mapView.showAnnotations(storePins, animated: true)
        }
    }
    
    private func updateMapViewState() {
        
    }
}
