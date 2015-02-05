//
//  TaskDocument.swift
//  Tasks
//
//  Created by Денис Львович on 29.01.15.
//  Copyright (c) 2015 Денис Львович. All rights reserved.
//

import UIKit

class TaskDocument: UIDocument {
    
    var docWrapper = NSFileWrapper(directoryWithFileWrappers: [:] )
    var tasks = [Task]() // тут храним массив с задачами
    
    // documentURL – функция, которая определяет и возвращает ссылку к папке Documents приложения
    class func documentURL() -> NSURL {
        var docURL:NSURL? = NSURL()
        if docURL == nil {
            let fileManager = NSFileManager.defaultManager()
            docURL = fileManager.URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true, error: nil)
            docURL = docURL!.URLByAppendingPathComponent("My Tasks list." + "tasks")
        }
        
        return docURL!
    }
    
    // documentAtURL – функция, которая открывает и сохраняет документ по указанной ссылке
    class func documentAtURL(url : NSURL) -> TaskDocument{
        let document = TaskDocument(fileURL: url)
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(url.path!) == true {
            document.openWithCompletionHandler(nil)
        }else{
            document.saveToURL(url, forSaveOperation: UIDocumentSaveOperation.ForCreating, completionHandler: nil)
        }
        
        return document
    }
    
    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {

        var wrapper = docWrapper.fileWrappers["tasks.data"] as NSFileWrapper?
        if wrapper != nil {
            docWrapper.removeFileWrapper(wrapper!)
        }
        
        var tasksData:NSData = NSKeyedArchiver.archivedDataWithRootObject(tasks)
        docWrapper.addRegularFileWithContents(tasksData, preferredFilename: "tasks.data")
        return docWrapper
    }
    
    override func loadFromContents(contents: AnyObject, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        docWrapper = contents as NSFileWrapper
        var wrapper = docWrapper.fileWrappers["tasks.data"] as NSFileWrapper?
        let data = wrapper?.regularFileContents
        if data != nil {
            tasks = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as [Task]
        }

        self.sendNotification("DataLoaded")
        return true
    }
    
    
    //Создаёт синглтон, объект класса
    class var sharedInstance :TaskDocument {
        struct Singleton {
            static let instance = TaskDocument.documentAtURL(TaskDocument.documentURL())
        }
        
        return Singleton.instance
    }
    
    //Определяем уведомления
    func sendNotification(notification : String){
        switch notification {
            
        case "ItemAdded": //Новая задача добавлена
            NSNotificationCenter.defaultCenter().postNotificationName("ItemAddedRightNow", object: self)
            
        case "TaskCompleted": //Задача выполнена
            NSNotificationCenter.defaultCenter().postNotificationName("TaskAccomplished", object: self)
            
        case "DataLoaded": //Данные загружены, нужно перезагрузить таблицу
            NSNotificationCenter.defaultCenter().postNotificationName("DataLoaded", object: self)
            
        default:
            break
        }
    }
}
