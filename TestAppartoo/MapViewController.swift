//
//  ViewController.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: Attributs
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let initialLocation = CLLocation(latitude: 48.8534100, longitude: 2.3488000)
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func centerMapOnSingleBar(bar: Bar) {
        
    }
    
    func showMapWithAllBars(bars: [Bar]) {
        
    }

}

