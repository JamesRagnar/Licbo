//
//  Store.swift
//  licbo
//
//  Created by James Harquail on 2017-10-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation

protocol StoreProtocol {
    var name: String? { get }
    var location: CLLocationCoordinate2D? { get }
}

class Store {
    
    fileprivate var data: [String: Any]?
    
    init(data: [String: Any]?) {
        self.data = data
    }
}

extension Store: StoreProtocol {
    
    var name: String? {
        return data?["name"] as? String
    }
    
    var location: CLLocationCoordinate2D? {
        guard
            let latitude = data?["latitude"] as? CLLocationDegrees,
            let longitude = data?["longitude"] as? CLLocationDegrees
            else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
