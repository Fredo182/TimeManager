//
//  ViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/7/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var dateScrollView: UIScrollView!
    @IBOutlet var projectScrollView: UIScrollView!
    @IBOutlet weak var progressbar: MCPercentageDoughnutView!
    
    var DatesArray: [NSDate] = []
    var charges: [Charge] = []                      // All the charges not grouped
    var projectCharges: [ProjectCharge] = []        // Charges grouped by project
    var selectedDate: NSDate!
    var projectIndex: Int!
    var dateLabelsArray: [[UILabel!]] = []
    
    var appDel:AppDelegate!
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Get context from delegate for core data
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel.managedObjectContext
        
        loadDates()                     // Create the dates
        loadDatesView()                 // Render the dates in scrollview
        
        loadCharges()                   // Load charges for selectedDate
        calcCharges()                   // Group and total the total hours for charges
        
        createProjectScrollView()       // Create the projects scrollview
        loadProgressBar()               // Render the circular progress bar
    }
    
    func dateButtonPressed(sender: UIButton!){
        selectedDate = DatesArray[sender.tag];
        print("Selected: \(selectedDate.printTime())")
        loadCharges()
        calcCharges()
        createProjectScrollView()
        scrollViewDidEndDecelerating(projectScrollView)
        
        resetDateLabelColors()
        colorSelectedLabel(dateLabelsArray[sender.tag][0], number: dateLabelsArray[sender.tag][1], day: dateLabelsArray[sender.tag][2])
    }
    
    func loadProgressBar(){
        self.progressbar.textStyle               = MCPercentageDoughnutViewTextStyleUserDefined;
        self.progressbar.percentage              = 0.0;
        self.progressbar.linePercentage          = 0.15;
        self.progressbar.animationDuration       = 1.5;
        
        self.progressbar.fillColor = blueColor()
        self.progressbar.roundedBackgroundImage = UIImage(named: "center");
        self.progressbar.roundedImageOverlapPercentage = 0.06;
        
        self.progressbar.unfillColor = UIColor(red: 120.0/255, green: 120.0/255, blue: 120.0/255, alpha: 1.0);
        self.progressbar.showTextLabel           = true;
        self.progressbar.animatesBegining        = true;
        
        self.progressbar.textLabel.textColor     = UIColor.whiteColor();
        self.progressbar.textLabel.text          = "0.0";
        self.progressbar.textLabel.font          = UIFont(name: "OSP-DIN", size: 150);
        
        if(projectCharges.count > 0)
        {
            scrollViewDidEndDecelerating(projectScrollView)
        }
    }
    

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        let index:Int = Int(page)
        var total = CGFloat(0)
        
        for p in projectCharges
        {
            total += CGFloat(p.time)
        }
        
        if(projectCharges.count > 0) {
            progressbar.textLabel.text = "\(total)"
            progressbar.percentage = CGFloat(projectCharges[index].time)/total
        }
        else {
            progressbar.textLabel.text = "0.0"
            progressbar.percentage = CGFloat(0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcCharges(){
        
        projectCharges.removeAll()
        
        var p = [Project:Double]()
        for charge in charges
        {
            if((p[charge.project]) != nil)
            {
                p[charge.project] = p[charge.project]! + charge.time
            }
            else
            {
                p[charge.project] = charge.time
            }
        }
        
        for (p,v) in p {
            let projectCharge = ProjectCharge()
            projectCharge.project = p
            projectCharge.time = v
            projectCharges.append(projectCharge)
        }
    }
    
    func createProjectScrollView(){
        
        let screenwidth = self.view.frame.size.width
        projectScrollView.delegate = self
        projectScrollView.frame.size.width = screenwidth
        projectScrollView.frame.size.height = 80
        
        // first clear out subviews
        let subviews = projectScrollView.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        
        if(projectCharges.count > 0)
        {
            var frame:CGRect = CGRect()
            for var i = 0; i < projectCharges.count; i++
            {
                if(i == 0)
                {
                    let projectView = ProjectView(frame:CGRectMake(0, 0,screenwidth, 80))
                    projectView.chargeLabel.text = projectCharges[i].project.chargeCode
                    projectView.projectLabel.text = projectCharges[i].project.projectName
                    projectView.timeLabel.text = "\(projectCharges[i].time)"
                    projectScrollView.addSubview(projectView);
                    frame = projectView.frame
                }
                else
                {
                    let projectView = ProjectView(frame: CGRectMake(0, 0, screenwidth, 80))
                    frame.origin.x = screenwidth * CGFloat(i)
                    projectView.frame = frame
                    projectView.chargeLabel.text = projectCharges[i].project.chargeCode
                    projectView.projectLabel.text = projectCharges[i].project.projectName
                    projectView.timeLabel.text = "\(projectCharges[i].time)"
                    projectScrollView.addSubview(projectView)
                }
            }
            
            projectScrollView.contentSize = CGSizeMake(screenwidth * CGFloat(projectCharges.count), self.projectScrollView.frame.size.height)
        }
        else
        {
            let projectView = ProjectView(frame:CGRectMake(0, 0,screenwidth, 80))
            self.projectScrollView.addSubview(projectView);
            
            projectScrollView.contentSize = CGSizeMake(screenwidth, self.projectScrollView.frame.size.height)
        }
    }
    
    
    /****************************************************************************************
    * This function will load all of the charges and get a total of hours for each project
    * and append it to the array. Not grouped by project yet.
    *****************************************************************************************/
    func loadCharges(){
        
        charges.removeAll()
        
        let predicate = NSPredicate(format: "dateKey == %@", selectedDate.toKey())
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
    
    /****************************************************************************************
    * This function loads up all the dates into the DatesArray variable. This will first
    * append the 7 days before today, todays date, then it will append the next 7 days
    *****************************************************************************************/
    func loadDates() {
        
        // Set variables for today and array of dates
        let today = NSDate()
        
        // Get the previous 7 days starting with latest
        for var i = 7; i > 0; i--
        {
            let date = today-i.day
            DatesArray.append(date)
        }
        
        // Append today in the middle of array
        DatesArray.append(today)
        if(selectedDate == nil) {
            selectedDate = today
        }
        
        // Get the next 7 days starting with earliest
        for var i = 1; i < 8; i++
        {
            let date = today+i.day
            DatesArray.append(date)
        }
    }
    
    /****************************************************************************************
    * This function loads all the dates into the scroll view. It will render all the
    * dates in order and in the end set the scrollview offset to start in the middle dates
    *****************************************************************************************/
    func loadDatesView() {
        
        let screenwidth = self.view.frame.size.width
        self.dateScrollView.frame.size.width = screenwidth
        self.dateScrollView.frame.size.height = 97
        
        var counter = 0
        
        for var i = 0; i<5; i++ {
            
            let dview = DatesView(frame:CGRectMake(0, 0,screenwidth, 97))
            dview.frame.origin.x = screenwidth * CGFloat(i)
            
            dview.firstMonthLabel.text = DatesArray[counter].shortMonth()
            dview.firstNumberLabel.text = DatesArray[counter].shortDate()
            dview.firstDayLabel.text = DatesArray[counter].shortDay()
            dview.firstDateButton.tag = counter;
            dview.firstDateButton.addTarget(self, action: "dateButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            if(checkIfSelectedDate(DatesArray[counter]))
            {
                colorSelectedLabel(dview.firstMonthLabel, number: dview.firstNumberLabel, day: dview.firstDayLabel)
            }
            let firstLabelArray = [dview.firstMonthLabel, dview.firstNumberLabel, dview.firstDayLabel]
            dateLabelsArray.append(firstLabelArray)
            
            counter++
            
            dview.secondMonthLabel.text = DatesArray[counter].shortMonth()
            dview.secondNumberLabel.text = DatesArray[counter].shortDate()
            dview.secondDayLabel.text = DatesArray[counter].shortDay()
            dview.secondDateButton.tag = counter;
            dview.secondDateButton.addTarget(self, action: "dateButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if(checkIfSelectedDate(DatesArray[counter]))
            {
                colorSelectedLabel(dview.secondMonthLabel, number: dview.secondNumberLabel, day: dview.secondDayLabel)
            }
            let secondLabelArray = [dview.secondMonthLabel, dview.secondNumberLabel, dview.secondDayLabel]
            dateLabelsArray.append(secondLabelArray)
            
            counter++
            
            dview.thirdMonthLabel.text = DatesArray[counter].shortMonth()
            dview.thirdNumberLabel.text = DatesArray[counter].shortDate()
            dview.thirdDayLabel.text = DatesArray[counter].shortDay()
            dview.thirdDateButton.tag = counter
            dview.thirdDateButton.addTarget(self, action: "dateButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if(checkIfSelectedDate(DatesArray[counter]))
            {
                colorSelectedLabel(dview.thirdMonthLabel, number: dview.thirdNumberLabel, day: dview.thirdDayLabel)
            }
            let thirdLabelArray = [dview.thirdMonthLabel, dview.thirdNumberLabel, dview.thirdDayLabel]
            dateLabelsArray.append(thirdLabelArray)
            
            counter++
            
            self.dateScrollView.addSubview(dview)
            
        }
        
        self.dateScrollView.contentSize = CGSizeMake(screenwidth * 5, self.dateScrollView.frame.size.height)
        self.dateScrollView.canCancelContentTouches = true
        self.dateScrollView.contentOffset.x = screenwidth * 2
        
    }
    
    func checkIfSelectedDate(compareDate: NSDate) ->Bool {
        print("Compare: " + compareDate.printTime() + " Selected: " + selectedDate.printTime())
        
        if(compareDate.shortMonth() == selectedDate.shortMonth() && compareDate.shortDate() == selectedDate.shortDate()) {
            print("EQUAL")
            return true
        }
        else {
            return false
        }
    }
    
    func colorSelectedLabel(month: UILabel, number: UILabel, day: UILabel)
    {
        month.textColor = blueColor()
        number.textColor = blueColor()
        day.textColor = blueColor()
    }
    
    func resetDateLabelColors()
    {
        for date in dateLabelsArray
        {
            date[0].textColor = .whiteColor()
            date[1].textColor = .whiteColor()
            date[2].textColor = .whiteColor()
        }
    }
    
    /****************************************************************************************
    * This function will return the main theme color
    *****************************************************************************************/
    func blueColor () -> UIColor {
        return UIColor(red: 15.0/255, green: 57.0/255, blue: 119.0/255, alpha: 1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTableView" {
            let destController = segue.destinationViewController as! TableViewController
            
            destController.date = selectedDate
            print("Setting new date: \(destController.date.printTime())")
        }
    }
}

