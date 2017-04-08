//
//  DashboardViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-07.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import RxSwift

protocol DashboardViewModelType {
    var menuItems: Observable<[String]> { get }
    func itemSelected(_ item: String)
}

class DashboardViewModel: DashboardViewModelType {
    
    private let items = ["Products", "Stores"]
    
    var menuItems: Observable<[String]> {
        return Observable.just(items)
    }
    
    func itemSelected(_ item: String) {
        
    }
}
