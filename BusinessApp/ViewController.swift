//
//  ViewController.swift
//  BusinessApp
//
//  Created by Matthew Schmale on 1/11/17.
//  Copyright © 2017 Matt Schmale. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

  
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    var token: String?
    var business: Business?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let businessInfo = business else {
            print("YO THERE AN ERROR")
            return
        }
        
        nameLbl.text = businessInfo.name
        priceLbl.text = businessInfo.price
        addressLbl.text = "\(businessInfo.location)"
        let imgURL = URL(string: businessInfo.imgUrl)
        imgView.setImageWith(imgURL!)
        
    }
    
}
