//
//  RootViewController.swift
//  Licbo
//
//  Created by James Harquail on 2017-04-04.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import UIKit
import GoogleMaps

class RootViewController: BaseViewController {

    private var viewModel: RootViewModelType
    
    private lazy var camera: GMSCameraPosition = {
        return GMSCameraPosition.camera(withLatitude: 43.4643, longitude: -80.5204, zoom: 13.0)
    }()
    
    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }()

    init(_ viewModel: RootViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(mapView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        mapView.padding = view.safeAreaInsets
    }
}
