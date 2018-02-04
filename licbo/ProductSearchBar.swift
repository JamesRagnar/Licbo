//
//  ProductSearchBar.swift
//  licbo
//
//  Created by James Harquail on 2018-02-03.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductSearchBar: UIView {

    @IBOutlet weak var textField: UITextField!

}

extension ProductSearchBar: SearchBarType {

    var queryString: Observable<String> {

        return textField
            .rx
            .text
            .asObservable()
            .map({ (text) -> String in
            if let text = text {
                return text
            }
            return ""
        })
    }
}

protocol SearchBarType: ViewModelType {

    var queryString: Observable<String> { get }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
