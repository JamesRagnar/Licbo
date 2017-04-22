//
//  AsynchronousNetworkOperation.swift
//  licbo
//
//  Created by James Harquail on 2017-04-21.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation

class AsynchronousNetworkOperation: AsynchronousOperation {
    
    private var url: URL
    private var response: NetworkResponseType

    init(_ url: URL, response: @escaping NetworkResponseType) {
        self.url = url
        self.response = response
        super.init()
    }

    override func execute() {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            self?.response(data, response, error)
            self?.finish()
        }.resume()
    }

    deinit {
        finish()
    }
}
