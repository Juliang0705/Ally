//
//  MapViewController.swift
//  Ally
//
//  Created by Juliang Li on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewController: UIViewController,MKMapViewDelegate {
    
    var rootURL:String?
    var userData: (UserType,NSDictionary?)?
    var location:(Double,Double)?
    @IBOutlet weak var map: MKMapView!
    var allyData: NSDictionary?
    var nameKeyDict:[String:String] = [:]
    var dataToBeSentToAllyInfoView:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "All Allies On Map"
        map.delegate = self
        setupMap()
    }
    func setupMap(){
        if let latitude = location?.0{
            if let longitude = location?.1{
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let regionRadius: CLLocationDistance = 600
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                    regionRadius * 2.0, regionRadius * 2.0)
                map.setRegion(coordinateRegion,animated: true)
                plotAllies()
            }
        }
    }

    func plotAllies(){
        let allyRef = Firebase(url: rootURL! + "ally")
        allyRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.allyData = snapshot.value as? NSDictionary
            if let data = self.allyData{
                for (key,obj) in data{
                    let value = obj as? NSDictionary
                    if let latitude = value?.valueForKey("latitude") as? Double{
                        if let longitude = value?.valueForKey("longitude") as? Double {
                            let dropPin = MKPointAnnotation()
                            dropPin.coordinate = CLLocationCoordinate2DMake(latitude,longitude)
                            dropPin.title = value?.valueForKey("name") as? String
                            if let availability = value?.valueForKey("availability") as? String{
                                if availability == "true"{
                                    dropPin.subtitle = "Available Now"
                                }else{
                                    dropPin.subtitle = "Unavailable"
                                }
                            }
                            self.map.addAnnotation(dropPin)
                            self.nameKeyDict[(value?.valueForKey("name") as? String)!] = key as? String
                        }
                    }
                }
            }
        })
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "location"
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        if annotationView.annotation!.subtitle! == "Available Now"{
            annotationView.pinTintColor = UIColor.greenColor()
        }else{
            annotationView.pinTintColor = UIColor.redColor()
        }
        annotationView.draggable = true
        annotationView.canShowCallout = true
        annotationView.animatesDrop = true

        let infoButton = UIButton(type: .InfoLight)
        infoButton.frame.size.width = 44
        infoButton.frame.size.height = 44
     //   infoButton.backgroundColor = UIColor.
        
        annotationView.rightCalloutAccessoryView = infoButton
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let key = nameKeyDict[(view.annotation?.title!)!]
        dataToBeSentToAllyInfoView = allyData![key!] as? NSDictionary
        self.performSegueWithIdentifier("AllyInfoViewController", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as? AllyInfoViewController
        destinationViewController?.allyInfo = dataToBeSentToAllyInfoView
    }
    
}
