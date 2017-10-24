//
//  LocationManager.swift
//  licbo
//
//  Created by James Harquail on 2017-10-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol UserLocationProtocol {
    var userLocation: Observable<CLLocationCoordinate2D?> { get }
}

class LocationManager: NSObject {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return locationManager
    }()
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    fileprivate lazy var lastRecordedLocation = Variable<CLLocationCoordinate2D?>(nil)
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastRecordedLocation.value = manager.location?.coordinate
    }
}

extension LocationManager: UserLocationProtocol {
    
    var userLocation: Observable<CLLocationCoordinate2D?> {
        return lastRecordedLocation.asObservable()
    }
}
