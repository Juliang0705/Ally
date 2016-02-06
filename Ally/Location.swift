//
//  Location.swift
//  Yelp
//
//  Created by Juliang Li on 1/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject,CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    var currentLocation:(Double,Double)?
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        update()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        currentLocation = (location.coordinate.latitude,location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        print ("Did update location \(currentLocation)")
    }

    func getCurrentLocation() -> (Double,Double)?{
        return currentLocation
    }
    func update(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}