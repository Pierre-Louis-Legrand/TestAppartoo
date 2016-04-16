//
//  BarTableViewController.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit
import MapKit


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
        cell.nameLabel.text = bar.title
        cell.tagsLabel.text = bar.tags
        
        // Téléchargement de l'image du bar
        let url = NSURL(string: bar.imageUrl)
        let data = NSData(contentsOfURL: url!)
        cell.photoImageView.contentMode = .ScaleAspectFill
        cell.photoImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let barDetailViewController = segue.destinationViewController as! BarMapViewController
        
        // L'utilisateur ne souhaite afficher qu'un bar
        if segue.identifier == "ShowSingleBar" {
            // Cherche la cellule qui a généré le segue
            if let selectedBarCell = sender as? BarTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedBarCell)!
                let selectedBar = barList[indexPath.row]
                barDetailViewController.centerMapOnSingleBar(selectedBar)
            }
        }
            // L'utilisateur veut voir la carte
        else if segue.identifier == "ShowMap" {
            // Affiche directement la map avec tous les bars
            barDetailViewController.showMapWithAllBars(barList)
        }
    }
    
    
    // MARK: Lecture du json
    
    func loadBarsFromFile() {
        
        // Chargement du fichier JSON
        if let path = NSBundle.mainBundle().pathForResource("bars", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil) {
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                    if let bars : NSArray = jsonResult["bars"] as? NSArray {
                        
                        // Parcourt de la liste des bars
                        for bar in bars {
                            // URL de la page World's Best Bars
                            let website = "http://www.worldsbestbars.com" + (bar["url"] as! String)
                            
                            // Liste des tags
                            var tags: String
                            if let tag = bar["tags"] as? Bool {
                                tags = "\(tag)"
                            } else {
                                tags = bar["tags"] as! String
                            }
                            
                            // Création de l'object bar
                            let b = Bar(id: bar["id"] as! Int,
                                adress: bar["address"] as! String,
                                name: bar["name"] as! String,
                                url: website,
                                tags: tags,
                                imageUrl: bar["image_url"] as! String,
                                coordinate: CLLocationCoordinate2D(latitude: bar["latitude"] as! Double, longitude: bar["longitude"] as! Double))
                            
                            // Ajout à la liste
                            barList += [b]
                        }
                    }
                }
            }
        }
    }
}
