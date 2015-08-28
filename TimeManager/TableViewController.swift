//
//  TableViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/17/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var numbers = ["3.5 hr","4.3 hr"]
    var starttimes = ["8:00AM", "11:30AM"]
    var stoptimes = ["11:30AM", "3:48PM"]
    var projects = ["AME", "SVMS"]
    
    @IBOutlet var headerLabel: UILabel!
    var charges = [Charge]()
    var date:NSDate!
    
    var appDel:AppDelegate!
    var context:NSManagedObjectContext!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = "\(date.shortDay()) \(date.shortMonth()) \(date.shortDate()) \(date.year)"
        
        // Get context from delegate for core data
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel.managedObjectContext
        
        // Table view stuff
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame:CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
                
        loadCharges()
        tableView.reloadData()

    }
    
    func loadCharges(){
        let predicate = NSPredicate(format: "dateKey == %@", date.toKey())
        let request = NSFetchRequest(entityName: "Charge")
        request.predicate = predicate
        do {
            let results:NSArray = try context.executeFetchRequest(request) as! [Charge]
            
            for charge in results
            {
                charges.append(charge as! Charge)
            }
        } catch {
            print("Error Loading Projects: \(error)")
        }
    }
    
    func deleteCharge(charge : Charge) -> Bool {
        
        do{
            let results = try context.existingObjectWithID(charge.objectID)
            context.deleteObject(results)
            try context.save()
            return true
            
        } catch {
            print ("Error deleting charge")
            return false
        }    
    }
    
    /********************************************************************************************
    // UITableViewDelegate Methods
    *********************************************************************************************/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Numver of items in the list
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charges.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TimeEntryCell
        
        cell.totalTimeLabel.text = "\(charges[indexPath.row].time) hr"
        cell.startTimeLabel.text = charges[indexPath.row].startTime.shortTime()
        cell.stopTimeLabel.text = charges[indexPath.row].stopTime.shortTime()
        cell.projectNameLabel.text = charges[indexPath.row].project.projectName
        
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
            if(deleteCharge(charges[indexPath.row]))
            {
                charges.removeAtIndex(indexPath.row)
                tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTimeEntry" {
            let destController = segue.destinationViewController as! TimeEntryViewController
            destController.currentDate = date
        }
    }


}
