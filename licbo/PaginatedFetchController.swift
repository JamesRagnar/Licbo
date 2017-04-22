//
//  PaginatedFetchController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-21.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

class PaginatedFetchController {

    var rootUrl: String?
    var requestQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    func start() {

    }
}
