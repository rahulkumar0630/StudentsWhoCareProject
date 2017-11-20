//
//  Capital.swift
//  StudentsWhoCareApp
//
//  Created by Rahul Kumar on 11/19/17.
//  Copyright © 2017 Rahul Kumar. All rights reserved.
//

import Foundation

import MapKit
import UIKit

class Capital: NSObject {
    //    var title: String?
    //    var coordinate: CLLocationCoordinate2D
    
    var name: String!
    var Address1: String!
    var Address2: String!
    var City:String!
    var Country:String!
    var Date:String!
    var PhoneNumber:String!
    var State:String!
    var ZipCode:String!
    
    init(name: String, Address1: String, Address2: String,City :String, Country:String, Date:String, PhoneNumber:String,
         State:String, ZipCode:String) {
        super.init()
        self.name = name
        self.Address1 = Address1
        self.Address2 = Address2
        self.City = City
        self.Country = Country
        self.Date = Date
        self.PhoneNumber = PhoneNumber
        self.State = State
        self.ZipCode = ZipCode
    }
}

