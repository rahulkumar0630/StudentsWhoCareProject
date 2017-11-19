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

class ViewControllerForAdminPanel: UIViewController, UITextFieldDelegate{
    @IBOutlet var MapForAdmin: MKMapView!
    static var ref: DatabaseReference!
    let StoringPin = Database.database().reference()
    let locationManager = CLLocationManager()
    var currentLoc:CLLocationCoordinate2D?
    var centerMap = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StoringPin.observe(.value, with: {
            snapshot in
            if snapshot.value is NSNull {
                return
            }
            let val = snapshot.value as! [String : [String : AnyObject]]
            
            
            for key in val.keys {
                //print(++self.increment)
                let Address1 = val[key]!["Address1"] as! String
                let Address2 = val[key]!["Address2"] as! String
                let City = val[key]!["City"] as! String
                let Country = val[key]!["Country"] as! String
                let Date = val[key]!["Date"] as! String
                let PhoneNumber = val[key]!["PhoneNumber"] as! String
                let State = val[key]!["State"] as! String
                let ZipCode = val[key]!["ZipCode"] as! String
               
                print(Address1)
                
                
                let Address = "\(Address1),\(City),\(State), \(ZipCode)"
                
                let artwork = Capital(Address1: Address, Address2: Address2, City: City,
                                      Country: Country, Date: Date, PhoneNumber: PhoneNumber,
                                      State: State, ZipCode: ZipCode);
                
                artwork.subtitle = Date
                
                
                Arrayforpins.append(artwork)
                
                self.MapForAdmin.addAnnotation(Arrayforpins[Arrayforpins.count - 1])
    
                
                for Capital in Arrayforpins {
                    
                    self.MapForAdmin.addAnnotation(Capital)
                    
                    
                }
                
                
            }
            
            
        })
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
        
        let annotationView = MKAnnotationView()
        let detailButton: UIButton = UIButton.init(type: .detailDisclosure) as UIButton
        annotationView.rightCalloutAccessoryView = detailButton
        
        
    }
    let regionRadius: CLLocationDistance = 1000

    func centerMapOnLocation(_ location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        MapForAdmin.setRegion(coordinateRegion, animated: true)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            MapForAdmin.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        //print("update")
        
        currentLoc = locValue
        
        if centerMap {
            centerMap = false
            centerMapOnLocation(CLLocation(latitude: currentLoc!.latitude, longitude: currentLoc!.longitude))
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "Capital"
        //print(++increment)
        
        if annotation.isKind(of: Capital.self) {
            
            // print("CAPITAL")
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView.annotation = annotation
                return annotationView
                
            } else {
                
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                //annotationView.pinColor = MKPinAnnotationColor.Green
                let btn = UIButton(type: .detailDisclosure)//                btn.addTarget(self, action: #selector(pressed), forControlEvents: .TouchUpInside)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
                
            }
        }
        
        return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

