//
//  ViewController.swift
//  Tasks
//
//  Created by Денис Львович on 28.12.14.
//  Copyright (c) 2014 Денис Львович. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib(){
        TaskList.sharedInstance.list.append(Task(name: "Задача 1"))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "insertNewObject", name: "ItemAddedRightNow", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "closeTask", name: "TaskAccomplished", object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskList.sharedInstance.list.count
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        self.performSegueWithIdentifier("taskSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let task = TaskList.sharedInstance.list[TaskList.sharedInstance.list.count - indexPath.row - 1] as Task
        if task.completed == true{
            let strikeThroughAttributes = [NSStrikethroughStyleAttributeName : 1]
            let strikeThroughString = NSAttributedString(string: TaskList.sharedInstance.list[TaskList.sharedInstance.list.count - indexPath.row - 1].taskName, attributes: strikeThroughAttributes)
            cell.textLabel?.attributedText = strikeThroughString
        }
        cell.textLabel?.text = task.taskName
        return cell
    }
    
    func insertNewObject() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        /*println("Массив \"Список дел:\"")
        println("Количество элементов: \(TaskList.sharedInstance.list.count)")
        println("Элементы: ")
        for i in TaskList.sharedInstance.list {
            println(i.taskName)
        }
        println("-------------------------")*/
    }
    
    func closeTask() {
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "taskSegue" {
            var indexPath = self.tableView.indexPathForSelectedRow()
            if indexPath == nil{
                indexPath = NSIndexPath(forRow: TaskList.sharedInstance.list.count-1, inSection: 0)
            }
            let smth = TaskList.sharedInstance.list[TaskList.sharedInstance.list.count - indexPath!.row - 1]
            (segue.destinationViewController as DetailedTaskViewController).task = smth
        }
        
        if segue.identifier == "newTaskSegue" {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            // handle delete (by removing the data from your array and updating the tableview)
            TaskList.sharedInstance.list.removeAtIndex(TaskList.sharedInstance.list.count - indexPath.row - 1)
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }


}

