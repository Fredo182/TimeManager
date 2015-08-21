//
//  TimeEntryViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/20/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class TimeEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var hoursArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var minuteArray = ["00", "06", "12", "18", "24", "30", "36", "42", "48", "54"]
    var suffixArray = ["AM", "PM"]
    var projectsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        projectsArray = ["AME","SVMS", "MOB"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UIPICKER DELEGATE METHODS
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
            return  projectsArray.count
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
            return projectsArray[row]
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
