//
//  TableViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/17/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var numbers = ["3.5 hr","4.3 hr"]
    var starttimes = ["8:00AM", "11:30AM"]
    var stoptimes = ["11:30AM", "3:48PM"]
    var projects = ["AME", "SVMS"]
    
    @IBOutlet var tableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Numver of items in the list
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TimeEntryCell
        
        cell.totalTimeLabel.text = numbers[indexPath.row]
        cell.startTimeLabel.text = starttimes[indexPath.row]
        cell.stopTimeLabel.text = stoptimes[indexPath.row]
        cell.projectNameLabel.text = projects[indexPath.row]
        
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do something when selected
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // TODO: DELETE from the list
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame:CGRectZero)
        tableView.separatorColor = UIColor.clearColor()

        // Do any additional setup after loading the view.
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
