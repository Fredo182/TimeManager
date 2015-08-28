//
//  ViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/7/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var dateScrollView: UIScrollView!
    @IBOutlet var projectScrollView: UIScrollView!
    @IBOutlet weak var progressbar: MCPercentageDoughnutView!
    
    var DatesArray: [NSDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDates();
        loadDatesView();
        
        let screenwidth = self.view.frame.size.width


        /**************************************************************************************************/
        /*       TEST PROJECT CHARGE SCROLL VIEW                   */
        
        
        self.projectScrollView.frame.size.width = screenwidth
        self.projectScrollView.frame.size.height = 80
        
        let pview1 = ProjectView(frame:CGRectMake(0, 0,screenwidth, 80))
        self.projectScrollView.addSubview(pview1);
        
        let pview2 = ProjectView(frame: CGRectMake(0, 0, screenwidth, 80))
        var frame = pview1.frame
        frame.origin.x = screenwidth
        pview2.frame = frame
        
        pview2.chargeLabel.text = "AWWW00135"
        pview2.projectLabel.text = "SVMS"
        pview2.timeLabel.text = "3.2"
        
        self.projectScrollView.addSubview(pview2)
        
        let pview3 = ProjectView(frame: CGRectMake(0, 0, screenwidth, 80))
        frame.origin.x = screenwidth * 2
        pview3.frame = frame
        
        pview3.chargeLabel.text = "EBS500043"
        pview3.projectLabel.text = "MOB"
        pview3.timeLabel.text = "1.2"
        
        self.projectScrollView.addSubview(pview3)
        
        self.projectScrollView.contentSize = CGSizeMake(screenwidth * 3, self.projectScrollView.frame.size.height)

        /**************************************************************************************************/
        
        
        /**************************************************************************************************/
        /*       TEST PROGRESS BAR VIEW                   */
        
        self.progressbar.textStyle               = MCPercentageDoughnutViewTextStyleUserDefined;
        self.progressbar.percentage              = 0.75;
        self.progressbar.linePercentage          = 0.15;
        self.progressbar.animationDuration       = 1.5;

        self.progressbar.fillColor = blueColor()
        self.progressbar.roundedBackgroundImage = UIImage(named: "center");
        self.progressbar.roundedImageOverlapPercentage = 0.06;
        
        self.progressbar.unfillColor = UIColor(red: 120.0/255, green: 120.0/255, blue: 120.0/255, alpha: 1.0);
        self.progressbar.showTextLabel           = true;
        self.progressbar.animatesBegining        = true;
        
        self.progressbar.textLabel.textColor     = UIColor.whiteColor();
        self.progressbar.textLabel.text          = "9.5";
        self.progressbar.textLabel.font          = UIFont(name: "OSP-DIN", size: 150);
        /**************************************************************************************************/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            counter++
            
            dview.secondMonthLabel.text = DatesArray[counter].shortMonth()
            dview.secondNumberLabel.text = DatesArray[counter].shortDate()
            dview.secondDayLabel.text = DatesArray[counter].shortDay()
            dview.secondDateButton.tag = counter;
            
            // This one is always today. Set to color blue
            if(i == 2)
            {
                dview.secondMonthLabel.textColor = blueColor()
                dview.secondNumberLabel.textColor = blueColor()
                dview.secondDayLabel.textColor = blueColor()
            }
            
            counter++
            
            dview.thirdMonthLabel.text = DatesArray[counter].shortMonth()
            dview.thirdNumberLabel.text = DatesArray[counter].shortDate()
            dview.thirdDayLabel.text = DatesArray[counter].shortDay()
            dview.thirdDateButton.tag = counter
            
            counter++
            
            self.dateScrollView.addSubview(dview)
            
        }
        
        self.dateScrollView.contentSize = CGSizeMake(screenwidth * 5, self.dateScrollView.frame.size.height)
        self.dateScrollView.canCancelContentTouches = true
        self.dateScrollView.contentOffset.x = screenwidth * 2
        
    }
    
    /****************************************************************************************
    * This function will return the main theme color
    *****************************************************************************************/
    func blueColor () -> UIColor {
        return UIColor(red: 15.0/255, green: 57.0/255, blue: 119.0/255, alpha: 1.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTableView" {
            print ("NEXT VIEW")
        }
    }
}

