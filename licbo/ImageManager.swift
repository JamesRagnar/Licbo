//
//  ImageManager.swift
//  licbo
//
//  Created by James Harquail on 2018-02-03.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ImageManager {

    private lazy var imageCache = [String: BehaviorSubject<UIImage?>]()

    private lazy var disposeBag = DisposeBag()

    func observable(for imageURL: String?) -> Observable<UIImage?> {
        guard let imageURL = imageURL else {
            print("ImageCache | Invalid URL")
            return Observable.just(nil)
        }

        guard let imageSubject = imageCache[imageURL] else {
            let imageSubject = BehaviorSubject<UIImage?>(value: nil)

            fetchImage(with: imageURL).subscribe(onSuccess: { (image) in
                imageSubject.onNext(image)
            }).disposed(by: disposeBag)

            imageCache[imageURL] = imageSubject
            return imageSubject
        }

        return imageSubject.asObservable()
    }

    private func fetchImage(with urlString: String) -> Single<UIImage> {
        return Single<UIImage>.create(subscribe: { (single) -> Disposable in

            print("Fetching \(urlString)")

            guard let url = URL(string: urlString) else {
                return Disposables.create()
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                single(.success(image))
            }.resume()

            return Disposables.create()
        })
    }
}
