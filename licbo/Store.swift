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

    var name: String? {
        return typedValue(for: "name")
    }

    var latitude: CLLocationDegrees? {
        return typedValue(for: "latitude")
    }

    var longitude: CLLocationDegrees? {
        return typedValue(for: "longitude")
    }

    var coordinate: CLLocationCoordinate2D {
        guard let latitude = latitude, let longitude = longitude else {
            return kCLLocationCoordinate2DInvalid
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
