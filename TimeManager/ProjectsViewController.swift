//
//  ProjectsViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/22/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit
import CoreData

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var projects = [Project]()
    
    var alert:AddProjectAlertView!
    var overlay:UIView!
    
    var appDel:AppDelegate!
    var context:NSManagedObjectContext!
    
    @IBOutlet var projectsTableView: UITableView!
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectsTableView.dataSource = self
        projectsTableView.backgroundColor = UIColor.clearColor()
        projectsTableView.tableFooterView = UIView(frame:CGRectZero)
        projectsTableView.separatorColor = UIColor.clearColor()
        
        let screenwidth = self.view.frame.size.width
        let screenheight = self.view.frame.size.height
        
        overlay = UIView(frame: CGRectMake(0, 0, screenwidth, screenheight))
        overlay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        overlay.hidden = true
        
        alert = AddProjectAlertView(frame:CGRectMake(0, screenheight ,screenwidth, 200))
        alert.cancelButton.addTarget(self, action: "cancelAddProjectAlert", forControlEvents: UIControlEvents.TouchUpInside)
        alert.doneButton.addTarget(self, action: "doneAddProjectAlert", forControlEvents: UIControlEvents.TouchUpInside)
        alert.projectName.delegate = self
        alert.chargeCode.delegate = self
        
        self.view.addSubview(overlay)
        self.view.addSubview(alert)
        
        // Get context from delegate for core data
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel.managedObjectContext
        
        //Set back image
        backgroundImage.image = appDel.backgroundImage

        // Load the projects
        loadProjects()
        projectsTableView.reloadData()
    }
    
    /********************************************************************************************
    // Button Actions.
    *********************************************************************************************/
    @IBAction func addProjectButtonPressed(sender: AnyObject) {
        toggleAddProjectAlert(true)
    }
    
    func cancelAddProjectAlert(){
        toggleAddProjectAlert(false)
    }
    
    func doneAddProjectAlert(){
        if((alert.projectName.text != "" && alert.chargeCode.text != ""))
        {
            saveProject()
            projectsTableView.reloadData()
        }
        toggleAddProjectAlert(false)
    }
    
    /********************************************************************************************
    // Alert View methods
    *********************************************************************************************/
    func toggleAddProjectAlert(show:Bool) {
        if(show)
        {
            UIView.animateWithDuration(0.3, animations: {
                self.alert.frame.origin.y = 150
            })
            
            mainView.userInteractionEnabled = false
            topView.userInteractionEnabled = false
            
            overlay.hidden = false
            
        }
        else
        {
            dismissKeyboard()
            
            alert.projectName.text = ""
            alert.chargeCode.text = ""
            
            UIView.animateWithDuration(0.3, animations: {
                self.alert.frame.origin.y = self.view.frame.height
            })
            mainView.userInteractionEnabled = true
            topView.userInteractionEnabled = true
            
            overlay.hidden = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        if let touch = touches.first {
            let point = touch.locationInView(self.view)
            if(!CGRectContainsPoint(alert.frame, point))
            {
                toggleAddProjectAlert(false)
                super.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    /********************************************************************************************
    // First Responder, Keyboard methods
    *********************************************************************************************/
    
    func dismissKeyboard(){
        alert.chargeCode.resignFirstResponder()
        alert.projectName.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == alert.projectName)
        {
            alert.chargeCode.becomeFirstResponder()
        }
        else
        {
            doneAddProjectAlert()
        }
        return true;
    }

    /********************************************************************************************
    // Core Data Methods
    *********************************************************************************************/
    func saveProject(){
        
        let newProject = NSEntityDescription.insertNewObjectForEntityForName("Project", inManagedObjectContext: context) as! Project
        
        newProject.projectName = alert.projectName.text!
        newProject.chargeCode = alert.chargeCode.text!
        
        // Save the context.
        do {
            try context.save()
            projects.append(newProject)
        } catch {
            print("Error Saving Projects: \(error)")
        }
    }
    
    func loadProjects(){
        
        let request = NSFetchRequest(entityName: "Project")
        
        do {
            let results:NSArray = try context.executeFetchRequest(request) as! [Project]
            
            for project in results
            {
                projects.append(project as! Project)
            }
        } catch {
            print("Error Loading Projects: \(error)")
        }
    }
    
    func deleteProject(project : Project) -> Bool {
        
        let predicate = NSPredicate(format: "projectName == %@", project.projectName)
        let request = NSFetchRequest(entityName: "Project")
        request.predicate = predicate
        
        
        do{
            let results = try context.executeFetchRequest(request) as! [Project]
            let deleteProject = results.first
            context.deleteObject(deleteProject!)
            try context.save()
            return true
            
        } catch {
            print("Error deleting Project")
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
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectcell", forIndexPath: indexPath) as! ProjectCell
        
        cell.chargeCodeLabel.text = projects[indexPath.row].chargeCode
        cell.projectNameLabel.text = projects[indexPath.row].projectName
        cell.backgroundColor = .clearColor()
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
            let p = projects[indexPath.row]
            if(deleteProject(p))
            {
                projects.removeAtIndex(indexPath.row)
            }
            projectsTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
