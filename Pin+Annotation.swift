//
//  Pin+Annotation.swift
//  Pin Drop
//
//  Created by Cal Stephens on 2/17/17.
//  Copyright © 2017 Alejandrina Patron. All rights reserved.
//
// Credit to GT iOS Club for providing resources for this project.

import MapKit
import UIKit

//CoreData already creates a Pin object, so we can just latch on to that.
extension Pin : MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.pinLat, longitude: self.pinLong)
    }
    
    public var title: String? {
        return self.pinName
    }
    
}
