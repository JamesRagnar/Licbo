//
//  Store.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Store: BaseResponseObject {

    public func name() -> String? {
        return typedValue(for: "name")
    }

    public func latitude() -> CLLocationDegrees? {
        return typedValue(for: "latitude")
    }

    public func longitude() -> CLLocationDegrees? {
        return typedValue(for: "longitude")
    }
}

extension Store: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        guard let latitude = latitude(), let longitude = longitude() else {
            return kCLLocationCoordinate2DInvalid
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
