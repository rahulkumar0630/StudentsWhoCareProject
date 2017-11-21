//
//  ViewControllerForInfo.swift
//  
//
//  Created by Rahul Kumar on 11/21/17.
//

import UIKit
import CoreLocation
import MapKit

class ViewControllerForInfo: UIViewController {

    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var Address1Label: UILabel!
    @IBOutlet var Address2Label: UILabel!
    @IBOutlet var CityLabel: UILabel!
    @IBOutlet var CountryLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var PhoneNumberLabel: UILabel!
    
    @IBOutlet var StateLabel: UILabel!
    @IBOutlet var ZipCodeLabel: UILabel!
    @IBOutlet var GetDirectionsButton: UIButton!
    
    static var name = ""
    static var address1 = ""
    static var address2 = ""
    static var city = ""
    static var country = ""
    static var date = ""
    static var phonenumber = ""
    static var state = ""
    static var zipcode = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = ViewControllerForInfo.name
        Address1Label.text = ViewControllerForInfo.address1
        
        if(ViewControllerForInfo.address2 != "")
        {
            Address2Label.text = ViewControllerForInfo.address2
        }
        else
        {
            Address2Label.text = "Not Provided"
        }
        CityLabel.text = ViewControllerForInfo.city
        CountryLabel.text = ViewControllerForInfo.country
        DateLabel.text = ViewControllerForInfo.date
        if(ViewControllerForInfo.phonenumber != "")
        {
            PhoneNumberLabel.text = ViewControllerForInfo.phonenumber
        }
        else
        {
            PhoneNumberLabel.text = "Not Provided"
        }
        StateLabel.text = ViewControllerForInfo.state
        ZipCodeLabel.text = ViewControllerForInfo.zipcode
        GetDirectionsButton.layer.cornerRadius = 10
        
    }
    
    static func DataRetrival(Data: Capital)
    {
        name = Data.name
        address1 = Data.Address1
        address2 = Data.Address2
        city = Data.City
        country = Data.Country
        date = Data.Date
        phonenumber = Data.PhoneNumber
        state = Data.State
        zipcode = Data.ZipCode
        
    }
    @IBAction func OnGetDirectionsPress(_ sender: Any) {
        
        let address = "\(ViewControllerForInfo.address1), \(ViewControllerForInfo.city), \(ViewControllerForInfo.state), \(ViewControllerForInfo.zipcode)"
        
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")
            let coords = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            let placemarks = MKPlacemark(coordinate: coords, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemarks)
            mapItem.name = "\(ViewControllerForInfo.name)"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
