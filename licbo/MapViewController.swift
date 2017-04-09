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

class MapViewController: UIViewController {
    
    private lazy var mapViewModel = MapViewModel()
    private lazy var disposeBag = DisposeBag()
    
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
    private lazy var locationManager = UserLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager
        .location
        .subscribe(onNext: { [weak self] (location) in
            guard let location = location else {
                return
            }
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if let userPin = self?.userLocationPin {
                userPin.coordinate = coordinate
                return
            }
            let userPin = MKPointAnnotation()
            userPin.coordinate = coordinate
            self?.mapView.addAnnotation(userPin)
            self?.userLocationPin = userPin
        }).disposed(by: disposeBag)
        
        locationManager.requestUserLocation()
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
