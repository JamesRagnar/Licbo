//
//  Product.swift
//  licbo
//
//  Created by James Harquail on 2018-01-26.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import RxSwift

class Product {

    fileprivate var nameSubject = BehaviorSubject<String?>(value: nil)
    fileprivate var imageURLSubject = BehaviorSubject<String?>(value: nil)

    init(data: [String: Any]?) {
        nameSubject.onNext(data?["name"] as? String)
        imageURLSubject.onNext(data?["image_url"] as? String)
    }
}

extension Product: ProductModelType {

    var name: Observable<String?> {
        return nameSubject.asObserver()
    }

    var imageURL: Observable<String?> {
        return imageURLSubject.asObserver()
    }
}

protocol ProductModelType: ViewModelType {
    var name: Observable<String?> { get }
    var imageURL: Observable<String?> { get }
}
