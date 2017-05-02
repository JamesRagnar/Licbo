//
//  BaseViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-08.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    open lazy var disposeBag = DisposeBag()

    typealias KeyboardUpdateTuple = (height: CGFloat, animationDuration: Double, animationCurve: UIViewAnimationOptions)

    static func keyboardObserver() -> Observable<KeyboardUpdateTuple> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(.UIKeyboardWillShow),
                NotificationCenter.default.rx.notification(.UIKeyboardWillHide)
                ])
            .merge()
            .map({ (notification) -> KeyboardUpdateTuple in
                let userInfo = notification.userInfo
                let height = (userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                let duration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
                let curve = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
                return (height, duration, UIViewAnimationOptions(rawValue: curve))
            })
            .startWith((0, 0, UIViewAnimationOptions(rawValue: 0)))
    }
}
