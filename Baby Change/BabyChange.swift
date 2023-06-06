//
//  BabyChange.swift
//  Baby Change
//
//  Created by Thomas Chatting on 06/06/2023.
//

import Foundation
import MapKit

class BabyChange: NSObject, MKAnnotation {
    let title: String?
    let desc: String?
    let floor: String?
    let rating: Float?
    let coordinate: CLLocationCoordinate2D
    
    init(
        title: String?,
        desc: String?,
        floor: String?,
        rating: Float?,
        coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.desc = desc
            self.floor = floor
            self.rating = rating
            self.coordinate = coordinate
            
            super.init()
        }
    
    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first as?
                MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with:propertiesData),
            let properties = json as? [String: Any]
        else {
            return nil;
        }
        
        title = properties["title"] as? String
        desc = properties["desc"] as? String
        floor = properties["floor"] as? String
        rating = properties["rating"] as? Float
        coordinate = point.coordinate
        super.init()
    }
    
    var subtitle: String? {
        return desc
    }
    
}
