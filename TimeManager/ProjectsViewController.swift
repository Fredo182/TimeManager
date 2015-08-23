//
//  ProjectsViewController.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/22/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var chargecode = ["EW3003100", "AWWW00135"]
    var projects = ["AME", "SVMS"]
    var alert:AddProjectAlertView!
    
    @IBOutlet var projectsTableView: UITableView!
    
    
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
        
        alert = AddProjectAlertView(frame:CGRectMake(0, screenheight ,screenwidth, 200))
        alert.cancelButton.addTarget(self, action: "dissmissAddProjectAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(alert)
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addProjectButtonPressed(sender: AnyObject) {

        UIView.animateWithDuration(0.3, animations: {
            
            self.alert.frame.origin.y = 150
        })
    }
    
    func dissmissAddProjectAlert(){
        UIView.animateWithDuration(0.3, animations: {
            
            self.alert.frame.origin.y = self.view.frame.height
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
