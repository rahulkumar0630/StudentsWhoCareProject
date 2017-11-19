//
//  ViewController.swift
//  StudentsWhoCareApp
//
//  Created by Rahul Kumar on 9/19/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet var SchedulePickup: UIView!
    @IBOutlet var DatePicker: UIDatePicker!
    static var ref: DatabaseReference!
    static var universalDate: UIDatePicker!
    @IBOutlet var ToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchedulePickup.layer.cornerRadius = 10
        SchedulePickup.layer.borderWidth = 4
        SchedulePickup.layer.borderColor = UIColor.orange.cgColor

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func OnAdminConsoleClick(_ sender: Any) {
        let alertControllerForAccess = UIAlertController(title: "Restricted Access!", message: "Please enter the password to enter Orders DB", preferredStyle: UIAlertControllerStyle.alert)
        
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Enter Password"
            tField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alertControllerForAccess.dismiss(animated: false, completion: nil)
        }
        
        let SubmitAction = UIAlertAction(title: "Enter", style: .default) { (action) in
            if(tField.text != "STClothe47")
            {
                alertControllerForAccess.dismiss(animated: false, completion: nil)
                let SorryController = UIAlertController(title: "Sorry", message: "The password you've entered is incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    SorryController.dismiss(animated: false, completion: nil)
                }
                SorryController.addAction(cancelAction)
                self.present(SorryController, animated: true, completion: nil)
                
            }
            else
            {
                print("ran")
                alertControllerForAccess.dismiss(animated: false, completion: nil)
                self.performSegue(withIdentifier: "SegueToAdminConsole", sender: self)
            }
        }
        alertControllerForAccess.addAction(SubmitAction)
        alertControllerForAccess.addAction(cancelAction)
        alertControllerForAccess.addTextField(configurationHandler: configurationTextField)
        
        
        
        self.present(alertControllerForAccess, animated: true, completion: nil)
    }
    
    @IBAction func OnSchedulePickupPress(_ sender: Any) {
        let userHasGotShippingInfoCompleted = UserDefaults.standard.object(forKey: "Shipping Setup") as? Bool
        if userHasGotShippingInfoCompleted == nil
        {
            ViewController.universalDate = DatePicker
            performSegue(withIdentifier: "SegueToShippingInfo", sender: self)
            
        }
        else{
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateString = formatter.string(from: DatePicker.date)
        print(dateString)
        
        let Name = UserDefaults.standard.object(forKey: "Name:") as! String
        let Address1 = UserDefaults.standard.object(forKey: "Address 1:") as! String
        let Address2 = UserDefaults.standard.object(forKey: "Address 2:") as! String
        let City = UserDefaults.standard.object(forKey: "City:") as! String
        let ZipCode = UserDefaults.standard.object(forKey: "Zip Code:") as! String
        let PhoneNumber = UserDefaults.standard.object(forKey: "Phone Number:") as! String
        let Country = UserDefaults.standard.object(forKey: "Country:") as! String
        let State = UserDefaults.standard.object(forKey: "State:") as! String
        
        
        ViewController.sendData(Name: Name, Date: dateString, Address1: Address1, Address2: Address2, City: City, ZipCode: ZipCode, PhoneNumber: PhoneNumber, Country: Country, State: State)
        }
    }
        
    
    static func sendData(Name:String, Date:String, Address1: String, Address2: String, City: String, ZipCode: String,
                  PhoneNumber:String, Country:String, State:String)
    {
        
        ref = Database.database().reference()
        var UID = UUID().uuidString
        var UIDandName = "\(Name): \(UID)"
        
        let post = [
            "Date": Date,
            "Address1":   Address1,
            "Address2":   Address2,
            "City": City,
            "ZipCode": ZipCode,
            "PhoneNumber": PhoneNumber,
            "Country": Country,
            "State": State
        ]
        
        ref?.child(UIDandName).setValue(post)
        
    }
}

