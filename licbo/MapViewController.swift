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

    private lazy var userPin: MKPointAnnotation = {
        [weak self] in
        let pin = MKPointAnnotation()
        self?.mapView.addAnnotation(pin)
        return pin
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(mapView)
    }

    private var userLocationPin: MKPointAnnotation?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapViewModel
            .stores
            .subscribe(onNext: { [weak self] (stores) in
                self?.updateMapPins(stores)
            }).addDisposableTo(disposeBag)

        mapViewModel
            .userLocation
            .subscribe(onNext: { [weak self] (location) in
                if let location = location {
                    self?.userPin.coordinate = location
                }
            }).addDisposableTo(disposeBag)

        mapViewModel.fetchStores()
    }

    private func updateMapPins(_ stores: [Store]) {
        var annotations = [MKPointAnnotation]()
        for store in stores {
            if let location = store.coordinates() {
                let pin = MKPointAnnotation()
                pin.coordinate = location
                annotations.append(pin)
            }
        }
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
}
