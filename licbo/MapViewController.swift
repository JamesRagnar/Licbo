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
        mapView.delegate = self

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
            if let userCoordinate = userlocation?.coordinate,
                storePins.count == 1,
                let storeLocation = storePins.first?.coordinate {
                // Show directions to store
                let userPlacemark = MKPlacemark(coordinate: userCoordinate)
                let storePlacemark = MKPlacemark(coordinate: storeLocation)
                let userMapItem = MKMapItem(placemark: userPlacemark)
                let storeMapItem = MKMapItem(placemark: storePlacemark)
                let request = MKDirectionsRequest()
                request.source = userMapItem
                request.destination = storeMapItem
                let directions = MKDirections(request: request)
                directions.calculate(completionHandler: { [weak self] (response, _) in
                    DispatchQueue.main.async {
                        if let routes = response?.routes {
                            for route in routes {
                                self?.mapView.add(route.polyline, level: .aboveRoads)
                            }
                        }
                    }
                })
            }
            var annotations: [MKAnnotation] = storePins
            mapView.addAnnotations(annotations)
            if let userlocation = userlocation {
                annotations.append(userlocation)
            }
            mapView.showAnnotations(annotations, animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyLine = overlay
        let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
        polyLineRenderer.strokeColor = .blue
        polyLineRenderer.lineWidth = 6
        return polyLineRenderer
    }
}
