//
//  Product.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

class Product: BaseResponseObject {
    
    public func name() -> String? {
        return typedValue(for: "name")
    }
}
