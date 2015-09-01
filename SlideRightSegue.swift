//
//  SlideRightSegue.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/31/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import Foundation
import UIKit

@objc(SlideRightSegue)
class SlideRightSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let sourceViewController = self.sourceViewController as UIViewController
        let destinationViewController = self.destinationViewController as UIViewController
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        sourceViewController.view.window?.layer.addAnimation(transition, forKey: nil)
        
        sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
        
        
    }
    
}