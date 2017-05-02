//
//  RootViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import RxSwift

enum RootViewControllerState {
    case dashboard
}

protocol RootViewModelType {
    var state: Variable<RootViewControllerState> { get }
}

class RootViewModel: RootViewModelType {
    var state = Variable<RootViewControllerState>(.dashboard)
}
