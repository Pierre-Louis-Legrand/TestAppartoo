//
//  Bar.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit

class Bar {
    
    // MARK: Properties
    var id: Int
    var adress: String
    var name: String
    var url: String
    var imageUrl: String
    var tags: String
    var latitude: Float
    var longitude: Float
    
    // MARK: Initialisation
    init?(id: Int, adress: String, name: String, url: String, tags: String, imageUrl: String, latitude: Float, longitude: Float) {
        // Affectation des attributs
        self.id = id
        self.name = name
        self.adress = adress
        self.url = url
        self.imageUrl = imageUrl
        self.tags = tags
        self.latitude = latitude
        self.longitude = longitude
        
        // Initialisation doit échouer pour un ID négatif ou un string vide
        if name.isEmpty || adress.isEmpty || imageUrl.isEmpty || url.isEmpty || tags.isEmpty || 0 > id {
            return nil
        }
    }
}