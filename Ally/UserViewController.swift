//
//  UserViewController.swift
//  Ally
//
//  Created by Juliang Li on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITabBarDelegate {

    
    var userData: (UserType,NSDictionary?)?
    var rootURL:String?
    var location:(Double,Double)? = (30.6014, -96.3144)
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        /*!!!!!!!!!!!!!!!!!ONLY WORK ON PHONE!!!!!!!!!!!*/
  //      let locationGetter = Location()
  //      location = locationGetter.getCurrentLocation()
    }
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if (item.tag == 1){
            self.performSegueWithIdentifier("MapViewController", sender: self)
        }
    }
    
    @IBAction func nonEmergencyButtonClicked(sender: UIButton) {
        
    }

    @IBAction func emergencyButtonClicked(sender: UIButton) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as? MapViewController
        destinationViewController?.userData = userData
        destinationViewController?.rootURL = rootURL
        destinationViewController?.location = location
    }

}
