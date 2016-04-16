//
//  BarTableViewCell.swift
//  TestAppartoo
//
//  Created by Pierre-Louis Legrand on 4/15/16.
//  Copyright (c) 2016 Pierre-Louis Legrand. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var bar: Bar?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: Action
    
    @IBAction func goToWebsite(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: bar!.url)!)
    }
    
}
