//
//  StoreMapPointAnnotation.swift
//  licbo
//
//  Created by James Harquail on 2017-04-21.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import MapKit

class StoreMapPointAnnotation: MKPointAnnotation {
    private(set) var store: Store

    init?(_ store: Store?) {
        guard let uStore = store,
            let coordinates = uStore.coordinates() else {
            return nil
        }
        self.store = uStore
        super.init()
        self.coordinate = coordinates
    }
}
