//
//  UserViewController.swift
//  Ally
//
//  Created by Juliang Li on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    
    var userData: (UserType,NSDictionary?)?
    var rootURL:String?
    var location:(Double,Double)? = (30.6014, -96.3144)
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.cornerRadius = 10
        button3.layer.cornerRadius = 10

        /*!!!!!!!!!!!!!!!!!ONLY WORK ON PHONE!!!!!!!!!!!*/
  //      let locationGetter = Location()
  //      location = locationGetter.getCurrentLocation()
    }
    @IBAction func nonEmergencyButtonClicked(sender: UIButton) {
        
    }
    
    @IBAction func seeAlliesOnMapButtonClicked(sender: UIButton) {
        self.performSegueWithIdentifier("MapViewController", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as? MapViewController
        destinationViewController?.userData = userData
        destinationViewController?.rootURL = rootURL
        destinationViewController?.location = location
    }

}
