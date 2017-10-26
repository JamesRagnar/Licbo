//
//  NetworkManager.swift
//  licbo
//
//  Created by James Harquail on 2017-10-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias NetworkResponseType = (Data?, URLResponse?, Error?) -> Swift.Void

class NetworkManager {
    
    private static let tempAccessToken = "Token MDpjY2YyMzU5Ni0xOWE0LTExZTctOWFjNy02ZmVkYzVlMTkwODg6azR2RVVOb2JLcWNEMTRGRmg0NEZiNzdFUEdXZGphR0lxSmNE"
    private static let tempGMapsAPIKey = "AIzaSyDyO_tOYt2q4jvxgBwZ7DHJsaD7YT2xP3A"
    
    private static let LCBORootURL = "https://lcboapi.com/"
    
    public static func GET(_ urlString: String?, callback: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        guard let urlString = urlString, let url = URL.init(string: urlString) else {
            callback(nil, nil, nil)
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: callback)
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
    
   
    
    public static func getDirections(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, callback: @escaping () -> Void) {
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(tempGMapsAPIKey)"
        
        NetworkManager.GET(url) { (data, response, error) in
            <#code#>
        }            guard let routes = response?["routes"] else {
                callback()
                return
            }
            
//            for route in routes
//            {
//                let routeOverviewPolyline = route["overview_polyline"].dictionary
//                let points = routeOverviewPolyline?["points"]?.stringValue
//                let path = GMSPath.init(fromEncodedPath: points!)
//                let polyline = GMSPolyline.init(path: path)
//                polyline.map = self.mapView
//            }
        }
    }
}
