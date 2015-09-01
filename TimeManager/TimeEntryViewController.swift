//
//  TimeEntryViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/20/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit
import CoreData

class TimeEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var startTimePicker: UIPickerView!
    @IBOutlet var stopTimePicker: UIPickerView!
    @IBOutlet var projectPicker: UIPickerView!
    
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var stopTimeLabel: UILabel!
    @IBOutlet var projectLabel: UILabel!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topView: UIView!
    
    var alert:AlertMessage!
    var overlay:UIView!
    
    //UIPicker data source
    let hoursArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let minuteArray = ["00", "06", "12", "18", "24", "30", "36", "42", "48", "54"]
    let suffixArray = ["AM", "PM"]
    var projects = [Project]()
    
    // Values to save
    var project:Project!
    var start:NSDate!
    var stop:NSDate!
    var time:Double!
    var currentDate:NSDate!
    
    var appDel:AppDelegate!
    var context:NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get context from delegate for core data
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel.managedObjectContext
        
        //Set random back image
        backgroundImage.image = appDel.backgroundImage
        
        // Overlay and alertview stuff
        let screenwidth = self.view.frame.size.width
        let screenheight = self.view.frame.size.height
        
        overlay = UIView(frame: CGRectMake(0, 0, screenwidth, screenheight))
        overlay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        overlay.hidden = true
        
        alert = AlertMessage(frame:CGRectMake(0, screenheight ,screenwidth, 160))
        alert.cancelButton.hidden = true
        alert.doneButton.hidden = true
        alert.messageLabel.text = "Please add a new project from projects menu."
        //alert.messageLabel.font = UIFont(name: "OSP-DIN", size: 20);
        alert.okButton.addTarget(self, action: "dismissAlert", forControlEvents: UIControlEvents.TouchUpInside)
        alert.tag = 0;
        
        self.view.addSubview(overlay)
        self.view.addSubview(alert)
        
        // Initial load
        loadProjects()
        projectPicker.reloadAllComponents()
        initPickers()
    }
    
    func initPickers(){
        
        // Set the default picker values
        startTimePicker.selectRow(7, inComponent: 0, animated: true)
        startTimePicker.selectRow(5, inComponent: 1, animated: true)
        startTimePicker.selectRow(0, inComponent: 2, animated: true)
        
        startTimeLabel.text = "\(hoursArray[startTimePicker.selectedRowInComponent(0)]):\(minuteArray[startTimePicker.selectedRowInComponent(1)])\(suffixArray[startTimePicker.selectedRowInComponent(2)])"
        
        stopTimePicker.selectRow(8, inComponent: 0, animated: true)
        stopTimePicker.selectRow(5, inComponent: 1, animated: true)
        stopTimePicker.selectRow(0, inComponent: 2, animated: true)
        
        stopTimeLabel.text = "\(hoursArray[stopTimePicker.selectedRowInComponent(0)]):\(minuteArray[stopTimePicker.selectedRowInComponent(1)])\(suffixArray[stopTimePicker.selectedRowInComponent(2)])"
        
        if(projects.count > 0) {
            projectPicker.selectRow(0, inComponent: 0, animated: true)
            projectLabel.text = projects[projectPicker.selectedRowInComponent(0)].projectName
        }
        else {
            projectLabel.text = ""
            toggleAlert(true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        // Get Project class from the value in the picker
        project = projects.filter{ $0.projectName == projectLabel.text }.first
        print("Project: \(project?.projectName) charge: \(project?.chargeCode)")
                
        // Get values from the pickers
        let startHours = hoursArray[startTimePicker.selectedRowInComponent(0)]
        let startMin = minuteArray[startTimePicker.selectedRowInComponent(1)]
        let startSuffix = suffixArray[startTimePicker.selectedRowInComponent(2)]
        
        let stopHours = hoursArray[stopTimePicker.selectedRowInComponent(0)]
        let stopMin = minuteArray[stopTimePicker.selectedRowInComponent(1)]
        let stopSuffix = suffixArray[stopTimePicker.selectedRowInComponent(2)]
        
        // Get NSDate classes from string values
        let startDateString =  "\(currentDate.shortMonth()) \(currentDate.shortDate()) \(currentDate.year) \(startHours):\(startMin) \(startSuffix)"
        start = startDateString.toDate(formatString: "MMM dd yyyy hh:mm a")
        print(start?.printTime())
        
        let stopDateString =  "\(currentDate.shortMonth()) \(currentDate.shortDate()) \(currentDate.year) \(stopHours):\(stopMin) \(stopSuffix)"
        stop = stopDateString.toDate(formatString: "MMM dd yyyy hh:mm a")
        print(stop?.printTime())
        
        time = (stop?.timeIntervalSinceDate(start!))!/3600
        print(time)
        
        if(start < stop)
        {
            if(saveCharge())
            {
                goBackToTableView()
            }
            else
            {
                alert.messageLabel.text = "Failed to save time."
                alert.tag = 2
                toggleAlert(true)
            }
        }
        else
        {
            alert.messageLabel.text = "Start time cannot be after stop time"
            alert.tag = 1
            toggleAlert(true)
        }
    }
    
    func goBackToTableView() {
        self.performSegueWithIdentifier("returnTableView", sender: self)
    }
    
    func dismissAlert(){
        toggleAlert(false)
    }
    
    /********************************************************************************************
    // Alert View methods
    *********************************************************************************************/
    func toggleAlert(show:Bool) {
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
            if(alert.tag == 0){
                goBackToTableView()
            }
            else {
                UIView.animateWithDuration(0.3, animations: {
                    self.alert.frame.origin.y = self.view.frame.height
                })
                mainView.userInteractionEnabled = true
                topView.userInteractionEnabled = true
            
                overlay.hidden = true
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        if let touch = touches.first {
            let point = touch.locationInView(self.view)
            if(!CGRectContainsPoint(alert.frame, point))
            {
                toggleAlert(false)
                super.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    /********************************************************************************************
    // Core Data Methods
    *********************************************************************************************/
    func saveCharge() -> Bool {
        
        let newCharge = NSEntityDescription.insertNewObjectForEntityForName("Charge", inManagedObjectContext: context) as! Charge
        
        newCharge.startTime = start
        newCharge.stopTime = stop
        newCharge.time = time
        newCharge.dateKey = currentDate.toKey()
        newCharge.project = project
        
        // Save the context.
        do {
            try context.save()
        } catch {
            print("Error Saving Projects: \(error)")
            return false
        }
        
        return true
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
    
    /********************************************************************************************
    // UIPickerView Methods
    *********************************************************************************************/
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 0 || pickerView.tag == 1 {
            return 3
        }
        else{
            return  1
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 || pickerView.tag == 1 {
            if(component == 0){
                return hoursArray.count
            }
            else if(component == 1){
                return minuteArray.count
            }
            else{
                return suffixArray.count
            }
        }
        else{
            return  projects.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 || pickerView.tag == 1 {
            if(component == 0){
                return hoursArray[row]
            }
            else if(component == 1){
                return minuteArray[row]
            }
            else{
                return suffixArray[row]
            }
        }
        else{
            return projects[row].projectName
        }

    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 || pickerView.tag == 1{
            var text: String
            if(component == 0){
                 text =  "\(hoursArray[row]):\(minuteArray[pickerView.selectedRowInComponent(1)])\(suffixArray[pickerView.selectedRowInComponent(2)])"
            }
            else if(component == 1){
                text =  "\(hoursArray[pickerView.selectedRowInComponent(0)]):\(minuteArray[row])\(suffixArray[pickerView.selectedRowInComponent(2)])"
            }
            else{
                text =  "\(hoursArray[pickerView.selectedRowInComponent(0)]):\(minuteArray[pickerView.selectedRowInComponent(1)])\(suffixArray[row])"
            }
            
            if(pickerView.tag == 0){
                startTimeLabel.text = text
            }
            else {
                stopTimeLabel.text = text
            }
        }
        else{
            projectLabel.text = "\(projects[row].projectName)"
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        var pickerLabel = view as! UILabel!
        if view == nil {
            pickerLabel = UILabel()
            pickerLabel.textColor = UIColor.whiteColor()
            pickerLabel.font = UIFont(name: "OSP-DIN", size: 30)
            pickerLabel.textAlignment = NSTextAlignment.Center
        }
        
        if pickerView.tag == 0 || pickerView.tag == 1 {
            pickerLabel.font = UIFont(name: "OSP-DIN", size: 35)
            if(component == 0){
                pickerLabel.text = hoursArray[row]
                return pickerLabel
            }
            else if(component == 1){
                pickerLabel.text = minuteArray[row]
                return pickerLabel
            }
            else{
                pickerLabel.text = suffixArray[row]
                return pickerLabel
            }
        }
        else{
            pickerLabel.text = projects[row].projectName
            return pickerLabel
        }

    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "returnTableView" {
            let destController = segue.destinationViewController as! TableViewController
            destController.date = currentDate
        }
    }

}
