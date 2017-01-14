//
//  BusinessesViewController.swift
//  BusinessApp
//
//  Created by Matthew Schmale on 1/13/17.
//  Copyright © 2017 Matt Schmale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AFNetworking

class BusinessesViewController: UITableViewController {

    var businesses: [Business?] = []
    
    var token: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func getToken(){
        Alamofire.request(baseUrl, method: .post, parameters: ["grand_type": "client_credentials", "client_id": clientId, "client_secret": secret], encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.isSuccess{
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                print(info)
                
                let json = JSON(info)
                print(json)
                
                self.token = json["access_token"].stringValue
                self.loadBusiness()
            }
        }
    }
    
    func loadBusiness(){
        Alamofire.request(searchUrl, method: .get, parameters: ["location": location], encoding: URLEncoding.default, headers: ["Authorization": "Bearer \(token!)"]).validate().responseJSON { (response) in
            if response.result.isSuccess{
                guard let info = response.result.value else {
                    print("Error")
                    return
                }
                // print(info)
                let json = JSON(info)
                // print(json)
                
                let businesses = json["businesses"].arrayValue
                
                let business = businesses[0]
                print(business)
                
                for businessJSON  in businesses {
                    let businessInfo = Business(json: businessJSON)
                    self.businesses.append(businessInfo)
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("Error")
            }
        }
    }





    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return businesses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        let row = indexPath.row
        
        guard let businessInfo = businesses[row] else {
            return cell
        }
        
        cell.nameLbl.text = businessInfo.name
        cell.addressLbl.text = businessInfo.location
        cell.priceLbl.text = businessInfo.price
        cell.distLbl.text = "\(businessInfo.distance)"
        cell.typeLbl.text = businessInfo.type
        cell.ratingLbl.text = "\(businessInfo.rating)"
        
        
        
        let imageURL = URL(string: businessInfo.imgUrl)
        cell.imgView.setImageWith(imageURL!)
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! BusinessCell
        let destination = segue.destination as! ViewController
        
        let row = tableView.indexPath(for: cell)?.row
        let business = businesses[row!]
        
        destination.business = business
    
    }
 

}
