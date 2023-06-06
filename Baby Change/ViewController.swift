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
        
        
        
        // Show baby changes on map
        let babyChange = BabyChange(
            title: "Trinity Shopping Centre",
            desc: "Baby change, family room, quiet, clean",
            floor: "2F",
            rating: 5.0,
            coordinate: CLLocationCoordinate2D(latitude: 53.79700956820782, longitude: -1.5440297444132693)
        )
        
        mapView.delegate = self
        
        mapView.addAnnotation(babyChange)
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
