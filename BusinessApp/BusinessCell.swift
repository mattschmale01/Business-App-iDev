//
//  BusinessCell.swift
//  BusinessApp
//
//  Created by Matthew Schmale on 1/13/17.
//  Copyright © 2017 Matt Schmale. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    //IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var distLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
