//
//  ViewController.swift
//  T_LocationServices
//
//  Created by Christopher Hsiao on 1/23/15.
//  Copyright (c) 2015 Chips&Tea. All rights reserved.
//

import UIKit
//Remember to add external library (search Core)
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Link w/ action
    @IBAction func findMyLocation(sender: AnyObject) {
        //The below lines sets the class as delegate for locationManager, specifies the location accuracy
        //and starts receiving location updates from CoreLocation.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // didUpdateLocations function is triggered when new location updates are available.
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
            // stop updating to conserve battery life
            locationManager.stopUpdatingLocation()
            println(placemark.locality)
            println(placemark.postalCode)
            println(placemark.administrativeArea)
            println(placemark.country)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }



}

