//
//  ViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/7/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var projectScrollView: UIScrollView!
    @IBOutlet weak var progressbar: MCPercentageDoughnutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.size.width
        print("Screen size width: \(self.view.frame.size.width)")
        
        self.projectScrollView.frame.size.width = width
        self.projectScrollView.frame.size.height = 80
        
        
        let p = ProjectView(frame:CGRectMake(0, 0,width, 80))
        self.projectScrollView.addSubview(p);
        
        let p1 = ProjectView(frame: CGRectMake(0, 0, width, 80))
        var frame1 = p.frame
        frame1.origin.x = width
        p1.frame = frame1
        
        self.projectScrollView.addSubview(p1)
        
        self.projectScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.projectScrollView.frame.size.height)
        self.projectScrollView.scrollEnabled = true;
        
        
        print("Scroll view: width=\(self.projectScrollView.frame.size.width) height=\(self.projectScrollView.frame.size.height)")
        print("Scroll view: content size width=\(self.projectScrollView.contentSize.width)")
        print("Scroll view: content size height=\(self.projectScrollView.contentSize.height)")
        
        print("ProjectView 1: width=\(p.frame.size.width) height=\(p.frame.size.height)")
        print("ProjectView 1: x=\(p.frame.origin.x) y=\(p.frame.origin.y)")

        print("ProjectView 2: width=\(p1.frame.size.width) height=\(p1.frame.size.height)")
        print("ProjectView 2: x=\(p1.frame.origin.x) y=\(p1.frame.origin.y)")

        
        // Do any additional setup after loading the view, typically from a nib.
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

