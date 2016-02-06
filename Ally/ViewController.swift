//
//  ViewController.swift
//  Ally
//
//  Created by Juliang Li on 2/5/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Firebase

enum UserType{
    case ALLY
    case USER
}
class LoginViewController: UIViewController {

    let rootURL = "https://sizzling-heat-3815.firebaseio.com/"
    var rootRef = Firebase(url: "https://sizzling-heat-3815.firebaseio.com/")
    var uid:String = ""
    var userData: (UserType,NSDictionary?)?
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var typeSegment: UISegmentedControl!
    
    @IBOutlet weak var submitButton: UIButton!
    var location:(Double,Double)? = nil
    let locationGetter = Location()
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
    }
    
    func initGUI(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        passwordTextField.secureTextEntry = true
        submitButton.layer.cornerRadius = 10
    }

    @IBAction func submitButtonClicked(sender: UIButton) {
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        let userType = typeSegment.selectedSegmentIndex
        rootRef.authUser(username, password: password){ error,result -> Void in
            if error == nil{
                print ("Login Succeeded")
                self.uid = result.uid
                if userType == 0{ // is ally
                    let allyRef = self.rootRef.childByAppendingPath("ally/\(self.uid)")
                    allyRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                        self.userData = (UserType.ALLY,snapshot.value as?NSDictionary)
                        if self.userData!.1 == nil{
                            let alert = UIAlertController(title: nil, message: "You are not an ally yet", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                            self.presentViewController(alert,animated: true,completion: nil)
                        }else{
                            self.performSegueWithIdentifier("AllyViewController", sender: self)
                        }
                    })
                }else if userType == 1{ // is user
                    let userRef = self.rootRef.childByAppendingPath("user/\(self.uid)")
                    userRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                        self.userData = (UserType.USER,snapshot.value as?NSDictionary)
                        if self.userData!.1 == nil{
                            let alert = UIAlertController(title: nil, message: "You are not an user", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                            self.presentViewController(alert,animated: true,completion: nil)
                        }else{
                            self.performSegueWithIdentifier("UserViewController", sender: self)
                        }
                    })
                }
            }else{
                //fail
                print("Login Failed")
                let alert = UIAlertController(title: nil, message: "Login Error", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alert,animated: true,completion: nil)
            }
        }
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController1 = segue.destinationViewController as? UserViewController
        destinationViewController1?.userData = userData
        destinationViewController1?.rootURL = rootURL
        
        let destinationViewController2 = segue.destinationViewController as? AllyViewController
        destinationViewController2?.userData = userData
        destinationViewController2?.rootURL = rootURL
        destinationViewController2?.uid = uid
        destinationViewController2?.location = self.locationGetter.getCurrentLocation()
    }

}

