//
//  FindStoresMenuViewModel.swift
//  licbo
//
//  Created by James Harquail on 2017-04-23.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol FindStoresMenuViewModelType {
    var viewFrame: Variable<CGRect> { get }
}

class FindStoresMenuViewModel: FindStoresMenuViewModelType {

    private struct Constants {

    }

    var viewFrame: Variable<CGRect> = Variable<CGRect>(.zero)
}
