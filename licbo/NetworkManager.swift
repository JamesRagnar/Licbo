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
    
    private static let tempGMapsAPIKey = "AIzaSyDyO_tOYt2q4jvxgBwZ7DHJsaD7YT2xP3A"
    
    public static func GET(_ urlString: String?, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let urlString = urlString, let url = URL.init(string: urlString) else {
            callback(nil, nil, nil)
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: callback)
        task.resume()
    }
    
    public static func getDirections(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, callback: @escaping (MapDirectionsProtocol?) -> Void) {
        
        let originString = "\(origin.latitude),\(origin.longitude)"
        let destinationString = "\(destination.latitude),\(destination.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originString)&destination=\(destinationString)&mode=driving&key=\(tempGMapsAPIKey)"
        
        NetworkManager.GET(url) { (data, response, error) in
            guard error == nil, let data = data else {
                callback(nil)
                return
            }
            
            guard
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let routes = json?["routes"] as? [Any],
                let routeData = routes.first as? [String: Any]
                else {
                    callback(nil)
                    return
            }
            
            let directions = MapDirections(data: routeData)
            if let _ = directions.polylinePoints {
                callback(directions)
            } else {
                callback(nil)
            }
        }
    }
}
