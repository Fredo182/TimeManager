//
//  ViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/7/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var progressbar: MCPercentageDoughnutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.progressbar.textStyle               = MCPercentageDoughnutViewTextStyleUserDefined;
        self.progressbar.percentage              = 0.75;
        self.progressbar.linePercentage          = 0.15;
        self.progressbar.animationDuration       = 1.5;

        self.progressbar.fillColor = UIColor(red: 15.0/255, green: 57.0/255, blue: 119.0/255, alpha: 1.0);
        self.progressbar.roundedBackgroundImage = UIImage(named: "center");
        self.progressbar.roundedImageOverlapPercentage = 0.04;
        
        self.progressbar.unfillColor = UIColor(red: 120.0/255, green: 120.0/255, blue: 120.0/255, alpha: 1.0);
        self.progressbar.showTextLabel           = true;
        self.progressbar.animatesBegining        = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

