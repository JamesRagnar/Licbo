//
//  MapViewController.swift
//  licbo
//
//  Created by James Harquail on 2017-04-05.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class MapViewController: BaseViewController {

    private lazy var mapViewModel = MapViewModel()

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: self.view.frame)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return mapView
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(mapView)
    }

    private var userLocationPin: MKPointAnnotation?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true

        let userLocationObserver =
            mapView
                .rx
                .didUpdateUserLocation
                .observeOn(MainScheduler.instance)

        let storePinsObserver =
            mapViewModel
                .storePins
                .asObservable()
                .observeOn(MainScheduler.instance)

        Observable
            .combineLatest(userLocationObserver, storePinsObserver) {
                return ($0, $1)
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (location, storePins) in
            self?.updateMapPins(location, storePins: storePins)
        }).addDisposableTo(disposeBag)

        mapView
            .rx
            .didSelectAnnotationView
            .observeOn(MainScheduler.instance)
            .map({ (view) -> Store? in
                return view.annotation as? Store
            })
            .subscribe(onNext: { [weak self] (annotation) in
                self?.mapViewModel.storeAnnotationSelected(annotation)
        }).disposed(by: disposeBag)

        mapView
            .rx
            .didDeselectAnnotationView
            .observeOn(MainScheduler.instance)
            .map({ (view) -> Store? in
                return view.annotation as? Store
            })
            .subscribe(onNext: { [weak self] (annotation) in
                self?.mapViewModel.storeAnnotationDeselected(annotation)
            }).disposed(by: disposeBag)

        mapViewModel.fetchStores()
    }

    private func updateMapPins(_ userlocation: MKUserLocation?, storePins: [Store]?) {
        if let storePins = storePins {
            mapView.addAnnotations(storePins)
            mapView.showAnnotations(storePins, animated: true)
        }
    }
    
    private func updateMapViewState() {
        
    }
}
