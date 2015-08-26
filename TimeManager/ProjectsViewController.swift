//
//  ProjectsViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/22/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var chargecode = ["EW3003100", "AWWW00135"]
    var projects = ["AME", "SVMS"]
    var alert:AddProjectAlertView!
    var overlay:UIView!
    
    @IBOutlet var projectsTableView: UITableView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var topView: UIView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Numver of items in the list
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectcell", forIndexPath: indexPath) as! ProjectCell
        
        cell.chargeCodeLabel.text = chargecode[indexPath.row]
        cell.projectNameLabel.text = projects[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectsTableView.dataSource = self
        projectsTableView.backgroundColor = UIColor.clearColor()
        projectsTableView.tableFooterView = UIView(frame:CGRectZero)
        projectsTableView.separatorColor = UIColor.clearColor()
        
        let screenwidth = self.view.frame.size.width
        let screenheight = self.view.frame.size.height
        
        overlay = UIView(frame: CGRectMake(0, 0, screenwidth, screenheight))
        overlay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        overlay.hidden = true
        
        alert = AddProjectAlertView(frame:CGRectMake(0, screenheight ,screenwidth, 200))
        alert.cancelButton.addTarget(self, action: "dissmissAddProjectAlert", forControlEvents: UIControlEvents.TouchUpInside)
        alert.doneButton.addTarget(self, action: "doneAddProjectAlert", forControlEvents: UIControlEvents.TouchUpInside)
        alert.projectName.delegate = self
        alert.chargeCode.delegate = self
        
        self.view.addSubview(overlay)
        self.view.addSubview(alert)
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addProjectButtonPressed(sender: AnyObject) {
        toggleAddProjectAlert(true)
    }
    
    func dissmissAddProjectAlert(){
        toggleAddProjectAlert(false)
    }
    
    func doneAddProjectAlert(){
        toggleAddProjectAlert(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func toggleAddProjectAlert(show:Bool) {
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
            dismissKeyboard()
            
            alert.projectName.text = ""
            alert.chargeCode.text = ""
            
            UIView.animateWithDuration(0.3, animations: {
                self.alert.frame.origin.y = self.view.frame.height
            })
            mainView.userInteractionEnabled = true
            topView.userInteractionEnabled = true
            
            overlay.hidden = true
        }
    }
    
    func dismissKeyboard(){
        alert.chargeCode.resignFirstResponder()
        alert.projectName.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        
        if let touch = touches.first {
            let point = touch.locationInView(self.view)
            if(!CGRectContainsPoint(alert.frame, point))
            {
                toggleAddProjectAlert(false)
                super.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == alert.projectName)
        {
            alert.chargeCode.becomeFirstResponder()
        }
        else
        {
            doneAddProjectAlert()
        }
        return true;
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
