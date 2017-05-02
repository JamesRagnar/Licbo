//
//  FindStoresViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

enum FindStoresViewControllerState {
    case base
    case search
}

protocol FindStoresViewModelType {
    var viewState: Observable<FindStoresViewControllerState> { get }
    func menuLabelTapped()
}

class FindStoresViewModel: FindStoresViewModelType {

    private var currentState = Variable<FindStoresViewControllerState>(.base)

    var viewState: Observable<FindStoresViewControllerState> {
        return currentState.asObservable()
    }

    func menuLabelTapped() {
        if currentState.value == .base {
            currentState.value = .search
        } else {
            currentState.value = .base
        }
    }
}
