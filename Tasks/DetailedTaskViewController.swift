//
//  DetailedTaskViewController.swift
//  Tasks
//
//  Created by Денис Львович on 28.12.14.
//  Copyright (c) 2014 Денис Львович. All rights reserved.
//

import UIKit

class DetailedTaskViewController: UIViewController {

    @IBOutlet weak var taskNameLabel: UILabel!
    var task: AnyObject? = AnyObject?()
    
    @IBAction func completeTask(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        TaskList.sharedInstance.sendNotification("TaskCompleted")
        (self.task as Task).completed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detail = self.task as? Task {
            if let nameLabel = self.taskNameLabel {
                nameLabel.text = detail.taskName
            }
        }
        
        // Do any additional setup after loading the view.
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
