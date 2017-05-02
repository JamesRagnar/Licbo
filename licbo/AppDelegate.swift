//
//  AppDelegate.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDnvqcJAhZr7NqB3sWNj1D2YLjIP_KEafI")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController(RootViewModel())
        window?.makeKeyAndVisible()
        return true
    }
}
