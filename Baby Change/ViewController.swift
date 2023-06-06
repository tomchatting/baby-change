//
//  ViewController.swift
//  Baby Change
//
//  Created by Thomas Chatting on 06/06/2023.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet private var mapView:
    MKMapView!
    
    private var babyChanges: [BabyChange] = []
    
    private func loadInitialData() {
        guard
            let fileName = Bundle.main.url(
                forResource: "BabyChanges",
                withExtension: "geojson"),
            let babyChangesData = try? Data(contentsOf: fileName)
        else {
            return
        }
        
        do {
            let features = try MKGeoJSONDecoder()
                .decode(babyChangesData)
                .compactMap { $0 as? MKGeoJSONFeature }
            
            let validChanges = features.compactMap(BabyChange.init)
            
            babyChanges.append(contentsOf: validChanges)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial location in Leeds
        let initialLocation = CLLocation(latitude: 53.7996, longitude: -1.5471)
        
        mapView.centerToLocation(initialLocation)
        
        let britainCenter = CLLocation(latitude: 53.94472, longitude: -2.52322)
        let region = MKCoordinateRegion(
            center: britainCenter.coordinate,
            latitudinalMeters: 1000000,
            longitudinalMeters: 500000
            )
        mapView.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000000)
        
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        mapView.delegate = self
        
        loadInitialData()
        
        mapView.addAnnotations(babyChanges)
    }

}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000) {
            let coordinateRegion = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: regionRadius,
                longitudinalMeters: regionRadius
                )
            setRegion(coordinateRegion, animated: true)
        }
}

extension ViewController: MKMapViewDelegate {
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? BabyChange else {
                return nil
            }
            let identifier = "babyChange"
            var view: MKMarkerAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(
                    annotation: annotation,
                    reuseIdentifier: identifier
                    )
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
}
