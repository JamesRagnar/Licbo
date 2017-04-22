//
//  BaseResponseObject.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

class BaseResponseObject {

    private let data: [String: Any]

    init?(_ data: [String: Any]?) {
        guard let uData = data else {
            return nil
        }
        self.data = uData
    }

    public func typedValue<T>(for key: String) -> T? {
        return data[key] as? T
    }
}
