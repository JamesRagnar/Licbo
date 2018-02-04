//
//  ViewModelBindableType.swift
//  licbo
//
//  Created by James Harquail on 2018-02-03.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation

protocol ViewModelBindableType {
    associatedtype ViewModelType
    func bind(_ viewModel: ViewModelType)
}
