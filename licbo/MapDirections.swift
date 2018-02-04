//
//  MapDirections.swift
//  licbo
//
//  Created by James Harquail on 2017-10-27.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

protocol MapDirectionsProtocol {
    var polylinePoints: String? { get }
}

class MapDirections {
    
    fileprivate var data: [String: Any]?
    
    init(data: [String: Any]?) {
        self.data = data
    }
    
    fileprivate var overview_polyline: [String: Any]? {
        return data?["overview_polyline"] as? [String: Any]
    }
}

extension MapDirections: MapDirectionsProtocol {
    var polylinePoints: String? {
        return overview_polyline?["points"] as? String
    }
}
