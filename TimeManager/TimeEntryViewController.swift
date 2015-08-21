//
//  TimeEntryViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/20/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class TimeEntryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var startTimePicker: UIPickerView!
    @IBOutlet var stopTimePicker: UIPickerView!
    @IBOutlet var projectPicker: UIPickerView!
    
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var stopTimeLabel: UILabel!
    @IBOutlet var projectLabel: UILabel!
    
    //UIPicker data source
    let hoursArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let minuteArray = ["00", "06", "12", "18", "24", "30", "36", "42", "48", "54"]
    let suffixArray = ["AM", "PM"]
    var projectsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        projectsArray = ["AME","SVMS", "MOB"]
        
        // Set the default picker values
        startTimePicker.selectRow(7, inComponent: 0, animated: true)
        startTimePicker.selectRow(5, inComponent: 1, animated: true)
        startTimePicker.selectRow(0, inComponent: 2, animated: true)
        
        stopTimePicker.selectRow(8, inComponent: 0, animated: true)
        stopTimePicker.selectRow(5, inComponent: 1, animated: true)
        stopTimePicker.selectRow(0, inComponent: 2, animated: true)
        
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
            projectLabel.text = "\(projectsArray[row])"
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
            pickerLabel.text = projectsArray[row]
            return pickerLabel
        }

    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
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
