//
//  TextMessageController.swift
//  Ally
//
//  Created by Rafa Moreno Cesar on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import MessageUI

class TextMessageController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var phone: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(phone)
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Hey I need help, are you available";
        messageVC.recipients = [phone!]
        messageVC.messageComposeDelegate = self;
        presentViewController(messageVC, animated: true, completion: {
          //  self.navigationController?.popViewControllerAnimated(true)
        })
        
    }
    
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
