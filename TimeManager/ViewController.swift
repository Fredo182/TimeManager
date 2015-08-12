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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenwidth = self.view.frame.size.width

        /**************************************************************************************************/
        /*       TEST DATE SCROLL VIEW                   */
        
        self.dateScrollView.frame.size.width = screenwidth
        self.dateScrollView.frame.size.height = 97
        
        let dview1 = DatesView(frame:CGRectMake(0, 0,screenwidth, 97))
        self.dateScrollView.addSubview(dview1)
        
        let dview2 = DatesView(frame:CGRectMake(0, 0,screenwidth, 97))
        var frame1 = dview1.frame
        frame1.origin.x = screenwidth
        dview2.frame = frame1
        
        dview2.firstMonthLabel.text = "Sep"
        dview2.secondMonthLabel.text = "Sep"
        dview2.thirdMonthLabel.text = "Sep"
        
        self.dateScrollView.addSubview(dview2)
        
        self.dateScrollView.contentSize = CGSizeMake(screenwidth * 2, self.dateScrollView.frame.size.height)
        
        
        self.dateScrollView.canCancelContentTouches = true;
        
        print("Date Scroll: x: \(self.dateScrollView.frame.origin.x)  y: \(self.dateScrollView.frame.origin.y)")
        print("Date Scroll: width: \(self.dateScrollView.frame.size.width)  height: \(self.dateScrollView.frame.size.height)")
        
        print("Date View 1: x: \(dview1.frame.origin.x)  y: \(dview1.frame.origin.y)")
        print("Date View 1: width: \(dview1.frame.size.width)  height: \(dview1.frame.size.height)")
        
        print("Date View 2: x: \(dview2.frame.origin.x)  y: \(dview2.frame.origin.y)")
        print("Date View 2: width: \(dview2.frame.size.width)  height: \(dview2.frame.size.height)")
        
        
        
        /**************************************************************************************************/
        
        
        
        
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

        self.progressbar.fillColor = UIColor(red: 33.0/255, green: 50.0/255, blue: 97.0/255, alpha: 1.0);
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


}

