//
//  Bar.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class Bar: NSObject, MKAnnotation {
    
    // MARK: Properties
    let id: Int
    let title: String
    let locationName: String
    let url: String
    let imageUrl: String
    let tags: String
    let coordinate: CLLocationCoordinate2D
    
    // MARK: Initialisation
    init(id: Int, adress: String, name: String, url: String, tags: String, imageUrl: String, coordinate: CLLocationCoordinate2D) {
        // Affectation des attributs
        self.id = id
        self.title = name
        self.locationName = adress
        self.url = url
        self.imageUrl = imageUrl
        self.tags = tags
        self.coordinate = coordinate
    }
    
    // MARK: Subtitle
    
    var subtitle: String {
        return locationName
    }
    
    // MARK: Helper
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}