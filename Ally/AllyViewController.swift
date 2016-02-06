//
//  AllyViewController.swift
//  Ally
//
//  Created by Juliang Li on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Firebase

class AllyViewController: UIViewController {
    
    var userData: (UserType,NSDictionary?)?
    var rootURL:String?
    var uid:String?
    var location:(Double,Double)? = nil
    @IBOutlet weak var detailText: UITextView!
    
    @IBOutlet weak var sharedButton: UIButton!
    let onMessage = "You are visible to the users that are seeking help now. You may receive text message or emails from users. Click share my coordinate to make your current location visible too."
    
    let offMessage = "You are invisible to the users now. Switch it back on to help others."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationGetter = Location()
        location = locationGetter.getCurrentLocation()
        sharedButton.layer.cornerRadius = 10
        print (userData)
        print (uid)
    }
    
    @IBAction func SwitchChanged(sender: UISwitch) {
        let value = sender.on
        print(value)
        let ref = Firebase(url: rootURL! + "ally/\(self.uid!)")
        if (value){ // turn on
            ref.updateChildValues(["availability":"true"])
            detailText.text = onMessage
        }else{ // turn off
            ref.updateChildValues(["availability":"false"])
            detailText.text = offMessage
        }
    }
    @IBAction func shareLocationButtonClicked(sender: AnyObject) {
        let ref = Firebase(url: rootURL! + "ally/\(self.uid!)")
        if let location = self.location{
            ref.updateChildValues(["latitude":location.0])
            ref.updateChildValues(["longitude":location.1])
            let alert = UIAlertController(title: nil, message: "Location Updated", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            self.presentViewController(alert,animated: true,completion: nil)
        }else{
            let alert = UIAlertController(title: nil, message: "Location Update Failed", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            self.presentViewController(alert,animated: true,completion: nil)
        }
    }

}
