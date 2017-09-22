//
//  ViewController.swift
//  StudentsWhoCareApp
//
//  Created by Rahul Kumar on 9/19/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var SchedulePickup: UIView!
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


}

