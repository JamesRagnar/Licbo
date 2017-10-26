//
//  LCBOAPINetworkManager.swift
//  licbo
//
//  Created by James Harquail on 2017-10-25.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

class LCBOAPINetworkManager {
    
    public static func getStores(near location: CLLocationCoordinate2D? = nil, result: @escaping ([Store]) -> Void) {
        
        var endpoint = "stores"
        
        if let latitude = location?.latitude,
            let longitude = location?.longitude {
            endpoint.append("?lat=\(latitude)&lon=\(longitude)&per_page=5")
        }
        
        LCBONetworkGET(endpoint: endpoint) { (data) in
            var responseData = [Store]()
            if let stores = data?["result"] as? [[String: Any]] {
                for storeData in stores {
                    responseData.append(Store(data: storeData))
                }
            }
            result(responseData)
        }
    }
}
