//
//  NetworkManager.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias NetworkResponseType = (Data?, URLResponse?, Error?) -> Swift.Void

class NetworkManager {

    // swiftlint:disable:next line_length
    private static let tempAccessToken = "Token MDpjY2YyMzU5Ni0xOWE0LTExZTctOWFjNy02ZmVkYzVlMTkwODg6azR2RVVOb2JLcWNEMTRGRmg0NEZiNzdFUEdXZGphR0lxSmNE"
    private static let rootURL = "https://lcboapi.com/"

    private static func get(_ endpoint: String?, result: @escaping ([String: Any]?) -> Void) {

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

    public static func getStores(withLocation location: CLLocation? = nil, result: @escaping ([Store]) -> Void) {

        var endpoint = "stores"

        if let latitude = location?.coordinate.latitude.description,
            let longitude = location?.coordinate.longitude.description {
            endpoint.append("?lat=" + latitude + "&lon=" + longitude + "&per_page=5")
        }

        get(endpoint) { (data) in
            var responseData = [Store]()
            if let stores = data?["result"] as? [[String: Any]] {
                for storeData in stores {

                }
            }
            result(responseData)
        }
    }
}
