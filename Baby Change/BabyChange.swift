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
    
    var subtitle: String? {
        return desc
    }
}
