//
//  ViewController.swift
//  Current Location Coordinates
//
//  Created by Henry Griffiths on 11/08/16.
//  Copyright © 2016 Henry Griffiths. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    var manager:CLLocationManager!
    
    @IBAction func updateLocationButton(sender: AnyObject) {
        
        UIPasteboard.generalPasteboard().string = "Latitude: \(latitudeLabel.text!) Longitude: \(longitudeLabel.text!)"
        
        
    }
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!

    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
   manager.startUpdatingLocation()
    
        
    
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        print(locations)
        
        var userLocation:CLLocation = locations[0]
        
        
       self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"

        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        reverseGeocoding(userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        
        
        
        
        
        
        
        
        

        
        
        
        
    }
    
    
    
    
    
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            else if placemarks?.count > 0 {
                let pm = placemarks![0]
                var address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                print("\n\(address)")
                self.addressLabel.text = "\n\(address)"
                if pm.areasOfInterest?.count > 0 {
                    let areaOfInterest = pm.areasOfInterest?[0]
                    print(areaOfInterest!)
                } else {
                    print("No area of interest found.")
                }
            }
        })
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  
    
    
    
    
    
    }

    
    
    
    
    
    
    

}

