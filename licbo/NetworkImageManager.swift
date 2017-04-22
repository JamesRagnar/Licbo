//
//  NetworkImageManager.swift
//  licbo
//
//  Created by James Harquail on 2017-04-21.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class NetworkImageManager: NSObject {

    private lazy var imageCache = [String: Variable<UIImage?>]()

    private lazy var imageRequestQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    func imageObservableForURL(_ url: String?) -> Observable<UIImage?>? {
        guard let urlString = url else {
            return nil
        }
        let imageVariable = cachedOrNewImageVariable(urlString)
        downloadImageIfNeeded(urlString, imageVariable: imageVariable)
        return imageVariable.asObservable()
    }

    private func cachedOrNewImageVariable(_ url: String) -> Variable<UIImage?> {
        if let existingImageVariable = imageCache[url] {
            return existingImageVariable
        }
        let newImageObservable = Variable<UIImage?>(nil)
        imageCache[url] = newImageObservable
        return newImageObservable
    }
    
    private func downloadImageIfNeeded(_ urlString: String, imageVariable: Variable<UIImage?>) {
        if imageVariable.value != nil {
            print("No need to fetch \(urlString)")
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        print("Downloading \(urlString)")
        let networkOperation = AsynchronousNetworkOperation(url) { (data, _, _) in
            print("Done \(urlString)")
            if let data = data {
                imageVariable.value = UIImage(data: data)
            }
        }
        imageRequestQueue.addOperation(networkOperation)
    }
}
