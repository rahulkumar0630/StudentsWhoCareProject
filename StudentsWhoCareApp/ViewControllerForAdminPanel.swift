//
//  ViewControllerForAdminPanel.swift
//  StudentsWhoCareApp
//
//  Created by Rahul Kumar on 11/19/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit
import MapKit
import FirebaseCore
import FirebaseDatabase

class ViewControllerForAdminPanel: UITableViewController, UITextFieldDelegate{

    static var ref: DatabaseReference!
    var refhandle: UInt!
    let StoringPin = Database.database().reference()
    let cellid = "cellid"
    
    var items: [Capital] = []
    var keynames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveData()

    }
    @IBAction func ReloadData(_ sender: Any) {
       items = []
       keynames = []
       tableView.reloadData()
       retrieveData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            items.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()

            
            StoringPin.child(keynames[indexPath.row]).removeValue(completionBlock:)({ (err, ref) in
                if err != nil {
                    print(err)
                } else {
                    print(ref)
                    print("Removed")
                    self.items = []
                    self.keynames = []
                    tableView.reloadData()
                    self.retrieveData()
                }
            })
            

            
            
        }
    }
    
    
    func retrieveData()
    {
        StoringPin.observe(.value, with: {
            
            snapshot in
            if snapshot.value is NSNull {
                return
            }
            let val = snapshot.value as! [String : [String : AnyObject]]
            
            
            for key in val.keys {
                //print(++self.increment)
                let name = val[key]!["Name"] as! String
                let Address1 = val[key]!["Address1"] as! String
                let Address2 = val[key]!["Address2"] as! String
                let City = val[key]!["City"] as! String
                let Country = val[key]!["Country"] as! String
                let Date = val[key]!["Date"] as! String
                let PhoneNumber = val[key]!["PhoneNumber"] as! String
                let State = val[key]!["State"] as! String
                let ZipCode = val[key]!["ZipCode"] as! String

                self.keynames.append(key)
                let capital = Capital(name: name, Address1: Address1, Address2: Address2, City: City, Country: Country, Date: Date, PhoneNumber: PhoneNumber, State: State, ZipCode: ZipCode)
                
                self.items.append(capital)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }
            
            
        })
        
    }
    
    

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



