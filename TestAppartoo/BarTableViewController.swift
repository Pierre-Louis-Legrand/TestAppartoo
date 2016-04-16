//
//  BarTableViewController.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit


class BarTableViewController: UITableViewController {
    
    // MARK: Attributs
    var barList = [Bar]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Chargement des bars
        loadBarsFromFile()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BarTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BarTableViewCell
        
        // Récupère le bar correspondant à la ligne
        let bar = barList[indexPath.row]
        
        cell.bar = bar
        
        // Affichage du tag et du nom du bar
        cell.nameLabel.text = bar.name
        cell.tagsLabel.text = bar.tags
        
        // Téléchargement de l'image du bar
        let url = NSURL(string: bar.imageUrl)
        let data = NSData(contentsOfURL: url!)
        cell.photoImageView.contentMode = .ScaleAspectFit
        cell.photoImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let barDetailViewController = segue.destinationViewController as! MapViewController
        
        if segue.identifier == "ShowSingleBar" {
            // Cherche la cellule qui a généré le segue
            if let selectedBarCell = sender as? BarTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedBarCell)!
                let selectedBar = barList[indexPath.row]
                barDetailViewController.centerMapOnSingleBar(selectedBar)
            }
        }
        else if segue.identifier == "ShowMap" {
            // Affiche directement la map avec tous les bars
            barDetailViewController.showMapWithAllBars(barList)
        }
    }
    
    
    // MARK: Lecture du json
    
    func loadBarsFromFile() {
        
        let first = Bar(id: 123,
            adress: "123 rue de la couille, 75002 Paris, France, Le Louvre, Paris",
            name: "Le bar de la grosse couille",
            url: "https://www.facebook.com",
            tags: "pute, soumis, gay",
            imageUrl: "https://goo.gl/0Alft5",
            latitude: 48.8534100,
            longitude: 2.3488000)!
        
        let second = Bar(id: 42,
            adress: "42 rue de la couille, 75002 Paris, France, Le Louvre, Paris",
            name: "Le bar de ta mère",
            url: "https://www.google.com",
            tags: "homo, alcool",
            imageUrl: "https://goo.gl/0Alft5",
            latitude: 49.8534100,
            longitude: 1.3488000)!
        
        barList += [first]
        
        if let path = NSBundle.mainBundle().pathForResource("BarsList", ofType: "geojson") {
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil) {
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                    if let bars : NSArray = jsonResult["bars"] as? NSArray {
                        // Parcourt de la liste des bars
                        for bar in bars {
                            // Création de l'object bar
                            let b = Bar(id: bar["id"] as! Int,
                                adress: bar["adress"] as! String,
                                name: bar["name"] as! String,
                                url: bar["url"] as! String,
                                tags: bar["tags"] as! String,
                                imageUrl: bar["image_url"] as! String,
                                latitude: bar["latitude"] as! Float,
                                longitude: bar["longitude"] as! Float)!
                            // Ajout à la liste
                            barList += [b]
                        }
                    }
                }
            }
        }
    }
}
