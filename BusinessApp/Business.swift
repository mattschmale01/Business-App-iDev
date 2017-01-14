//
//  Business.swift
//  BusinessApp
//
//  Created by Matthew Schmale on 1/13/17.
//  Copyright © 2017 Matt Schmale. All rights reserved.
//

import UIKit
import SwiftyJSON

class Business: NSObject {
    var name: String = ""
    var price: String = ""
    var location: String = ""
    var phoneNumber: String = ""
    var type: String = ""
    var imgUrl: String = ""
    
    var distance: Double = 0.0
    var rating: Double = 0.0
    
    init(json: JSON) {
        name = json["name"].stringValue
        price = json["price"].stringValue
        
        let jsonLoc = json["location"]["display_address"]
        location = "\(jsonLoc[0].stringValue), \n \(jsonLoc[1].stringValue)"
        
        rating = json["rating"].doubleValue
        distance = json["distance"].doubleValue
        phoneNumber = json["phone"].stringValue
        imgUrl = json["image_url"].stringValue
        
        let types = json["categories"].arrayValue
        for type in types {
            if (self.type == "") {
                self.type.append(type["alias"].stringValue)
            } else {
               self.type.append(", \(type["alias"].stringValue)")
            }
            print(self.type)
        }
        
        
    }
    
}
