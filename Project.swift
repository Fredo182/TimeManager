//
//  Project.swift
//  TimeManager
//
//  Created by Alfredo Castillo on 8/9/15.
//  Copyright © 2015 Alfredo Castillo. All rights reserved.
//

import Foundation
import CoreData

enum Day {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

enum Month {
    case Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
}

class Project: NSManagedObject {
    @NSManaged var projectName: String
    @NSManaged var chargeCode: String
}

class Charge: NSManagedObject {
    @NSManaged var project: Project
    @NSManaged var startTime: NSDate
    @NSManaged var stopTime: NSDate
    @NSManaged var time: Double
    @NSManaged var dateKey: String
}