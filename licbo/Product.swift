//
//  Product.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class Product: BaseResponseObject {

    var imageObservable: Observable<UIImage?>?

    var name: String? {
        return typedValue(for: "name")
    }

    var imageThumbnailUrl: URL? {
        return typedValue(for: "image_thumb_url")
    }

    var imageThumbnailUrlString: String? {
        return typedValue(for: "image_thumb_url")
    }
}
