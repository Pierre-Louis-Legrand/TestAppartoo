//
//  BarMapViewController.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit
import MapKit

class BarMapViewController: UIViewController {
    
    // MARK: Attributs
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 4000
    var barsToDisplay = [Bar]()
    var initialLocation: CLLocation?
    
    // MARK: Fonctions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        // Centre la carte sur la position initiale
        centerMapOnLocation(initialLocation!)
        
        // Affiche les bars à afficher
        mapView.addAnnotations(barsToDisplay)
    }
    
    // Centre l'affichage de la map sur la location passée en paramètre.
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // Affiche sur la carte sur un seul bar passé en paramètre.
    func centerMapOnSingleBar(bar: Bar) {
        barsToDisplay.removeAll(keepCapacity: false)
        barsToDisplay.append(bar)
        
        // Règle la position de départ sur le bar
        initialLocation = CLLocation(latitude: bar.coordinate.latitude, longitude: bar.coordinate.longitude)
    }
    
    // Affiche tous les bars sur la carte
    func showMapWithAllBars(bars: [Bar]) {
        barsToDisplay.removeAll(keepCapacity: false)
        for b in bars {
            barsToDisplay.append(b)
        }
        
        // Règle la position initiale sur le centre de la ville de Paris
        initialLocation = CLLocation(latitude: 48.856578, longitude: 2.351828)
    }
    
}
