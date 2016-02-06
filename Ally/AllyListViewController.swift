//
//  AllyListViewController.swift
//  Ally
//
//  Created by Rafa Moreno Cesar on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class AllyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var allyData: NSDictionary?
    var email: String?
    let ref = Firebase(url: "https://sizzling-heat-3815.firebaseio.com/ally")
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: FireBaseTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.dataSource = FirebaseTableViewDataSource(ref: self.ref, cellReuseIdentifier: "AllyCell", view: self.tableView)
        // Do any additional setup after loading the view.
        
        
    }
    
//    func populateCell(){
//        let allyRef = Firebase(url: rootURL! + "ally")
//        allyRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            self.allyData = snapshot.value as? NSDictionary
//            if let data = self.allyData{
//                for (key,obj) in data{
//                    let value = obj as? NSDictionary
//                    let latitude = value?.valueForKey("latitude") as? Double
//                    let longitude = value?.valueForKey("longitude") as? Double
//                    self.email = (value?.valueForKey("email") as? String)!
//                    
//                }
//            }
//        })
//
//    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        
//        return 1
//        
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        self.dataSource
//        return cell
//    }
    
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
