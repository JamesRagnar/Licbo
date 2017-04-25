//
//  FindStoresViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

protocol FindStoresViewModelType {
    var mapViewModel: MapViewModelType { get }
    var menuViewModel: FindStoresMenuViewModelType { get }
}

class FindStoresViewModel: FindStoresViewModelType {
    var mapViewModel: MapViewModelType = MapViewModel()
    var menuViewModel: FindStoresMenuViewModelType = FindStoresMenuViewModel()
}
