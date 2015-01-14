//
//  NewTaskViewController.swift
//  Tasks
//
//  Created by Денис Львович on 28.12.14.
//  Copyright (c) 2014 Денис Львович. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var taskName: UITextField!
    
    //var list: AnyObject? = AnyObject?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveTaskButton(sender: AnyObject) {
        if self.taskName.text == ""{
            var device : UIDevice = UIDevice.currentDevice();
            var systemVersion = device.systemVersion as NSString
            var iosVerion : Float = systemVersion.floatValue
            if (iosVerion < 8.0) {
                let alert = UIAlertView()
                alert.title = "Ошибка"
                alert.message = "Не может быть пустым"
                alert.addButtonWithTitle("OK")
                alert.show()
            } else {
                var alert = UIAlertController(title: "Ошибка", message: "Не может быть пустым", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }

            return
        } else {
            TaskList.sharedInstance.list.append(Task(name: self.taskName.text))
            TaskList.sharedInstance.sendNotification("ItemAdded")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
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
