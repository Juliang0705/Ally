//
//  AllyInfoViewController.swift
//  Ally
//
//  Created by Juliang Li on 2/6/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class AllyInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var allyInfo: NSDictionary?
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:[(String,String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        extractDataFromDictionary()
        tableView.reloadData()
    }
    func extractDataFromDictionary() {
        if let name = allyInfo!["name"] as? String{
            dataArray.append(("Name: ",name))
        }
        if let phone = allyInfo!["phone"] as? String{
            dataArray.append(("Phone: ",phone))
        }
        if let email = allyInfo!["email"] as? String{
            dataArray.append(("Email: ",email))
        }
        if let office = allyInfo!["office"] as? String{
            dataArray.append(("Office: ",office))
        }
        if let brief = allyInfo!["brief"] as? String{
            dataArray.append(("brief: ",brief))
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllyInfoCell", forIndexPath: indexPath) as! AllyInfoTableViewCell
        cell.titleLabel.text = dataArray[indexPath.row].0
        cell.descriptionLabel.text = dataArray[indexPath.row].1
        return cell
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
