//
//  AllyListViewController.swift
//  Ally
//
//  Created by Rafa Moreno Cesar on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Firebase

class AllyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allyData: NSDictionary?
    var email: String?
    let ref = Firebase(url: "https://sizzling-heat-3815.firebaseio.com/ally")
    var allyDataArray:[(String,String,String,String)] = []
    var phone :String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        populateCell()
    }
    
    func populateCell(){
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.allyData = snapshot.value as? NSDictionary
            if let data = self.allyData{
                for (_,obj) in data{
                    let value = obj as? NSDictionary
                    var tuple:(String,String,String,String) = ("","","","")
                    tuple.0 = (value?.valueForKey("name") as? String)!
                    tuple.1 = (value?.valueForKey("email") as? String)!
                    tuple.2 = (value?.valueForKey("phone") as? String)!
                    tuple.3 = (value?.valueForKey("availability") as? String)!
                    self.allyDataArray.append(tuple)
                }
                self.allyDataArray = self.allyDataArray.filter({ (_, _, _, availability) -> Bool in
                    return availability == "true"
                    })
                self.tableView.reloadData()
            }
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return allyDataArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllyCell") as! AllyCell
        cell.nameLabel.text = "Name: " + allyDataArray[indexPath.row].0
        cell.emailLabel.text = "Email: " + allyDataArray[indexPath.row].1
        cell.phoneLabel.text = "Phone: " + allyDataArray[indexPath.row].2
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        phone = allyDataArray[indexPath.row].2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.performSegueWithIdentifier("TextSegue", sender: nil)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destinationViewController as? TextMessageController
        destinationViewController!.phone = phone
    }
    
    
}