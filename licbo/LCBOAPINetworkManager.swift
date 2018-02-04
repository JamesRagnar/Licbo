//
//  LCBOAPINetworkManager.swift
//  licbo
//
//  Created by James Harquail on 2017-10-25.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation

class LCBOAPINetworkManager {
    
    private static let LCBORootURL = "https://lcboapi.com/"
    private static let tempAccessToken = "Token MDpjY2YyMzU5Ni0xOWE0LTExZTctOWFjNy02ZmVkYzVlMTkwODg6azR2RVVOb2JLcWNEMTRGRmg0NEZiNzdFUEdXZGphR0lxSmNE"

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

    public static func getProducts(_ result: @escaping ([Product]) -> Void) {
        let endpoint = "products"

        LCBONetworkGET(endpoint: endpoint) { (data) in
            var responseData = [Product]()
            if let products = data?["result"] as? [[String: Any]] {
                for productData in products {
                    responseData.append(Product(data: productData))
                }
            }
            result(responseData)
        }
    }
    
    private static func LCBONetworkGET(_ rootURL: String = LCBORootURL, endpoint: String?, result: @escaping ([String: Any]?) -> Void) {
        
        var urlString = rootURL
        
        if let endpoint = endpoint {
            urlString += endpoint
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var req = URLRequest(url: url)
        req.setValue(tempAccessToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: req) { (data, _, error) in
            if let error = error {
                print(error)
                result(nil)
                return
            }
            guard let data = data else {
                print("No Data")
                result(nil)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    result(json)
                    return
                }
            } catch {
                print("JSON Serialization Error")
            }
            result(nil)
            }.resume()
    }
}
