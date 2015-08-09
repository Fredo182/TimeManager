//
//  Project.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/9/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import Foundation

enum Day {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

enum Month {
    case Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
}

class Project {
    var name: String
    var chargecode: String
    
    init(name: String,chargecode: String) {
        self.name = name
        self.chargecode = chargecode
    }
}

class Charge {
    var project: Project
    var time: Float
    
    init(project: Project){
        self.project = project
        self.time = 0.0
    }
    
    init(project: Project, time: Float){
        self.project = project
        self.time = time
    }
    
    init(name:String, chargecode: String){
        self.project = Project(name: name, chargecode: chargecode)
        self.time = 0.0
    }
    
    init(name: String, chargecode: String, time:Float)
    {
        self.project = Project(name: name, chargecode: chargecode)
        self.time = time;
    }
}