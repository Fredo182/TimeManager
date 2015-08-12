//
//  UIButtonScrollView.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/12/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class UIButtonScrollView: UIScrollView {

    override func touchesShouldCancelInContentView(view: UIView!) -> Bool {
        if (view.isKindOfClass(UIButton)) {
            return true
        }
        
        return super.touchesShouldCancelInContentView(view)
        
    }

}
