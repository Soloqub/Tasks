//
//  Tasks.swift
//  Tasks
//
//  Created by Денис Львович on 02.01.15.
//  Copyright (c) 2015 Денис Львович. All rights reserved.
//

import UIKit

class Task: NSObject, NSCoding {
    
    var taskName = String()
    var completed = Bool()
    
    init (name: NSString) {
        self.taskName = name
        self.completed = false
        
    }
    
    required init(coder aDecoder: NSCoder) {
        self.taskName = aDecoder.decodeObjectForKey("TaskName") as NSString
        self.completed = aDecoder.decodeBoolForKey("Completed")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.taskName, forKey: "TaskName")
        aCoder.encodeBool(self.completed, forKey: "Completed")
    }
   
}

/*class TaskList {
    
    var list = [Task]()
    
    class var sharedInstance :TaskList {
        struct Singleton {
            static let instance = TaskList()
        }
        
        return Singleton.instance
    }
    
    func sendNotification(notification : String){
        switch notification {
            
            case "ItemAdded":
                NSNotificationCenter.defaultCenter().postNotificationName("ItemAddedRightNow", object: self)
            
            case "TaskCompleted":
                NSNotificationCenter.defaultCenter().postNotificationName("TaskAccomplished", object: self)
            
            default:
                break
        }
    }
}
*/