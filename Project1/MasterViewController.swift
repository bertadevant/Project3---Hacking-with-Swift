//
//  MasterViewController.swift
//  Project1
//
//  Created by Berta Devant on 11/6/15.
//  Copyright © 2015 Berta Devant. All rights reserved.
//

//Trinity: 
//Model - something that describes the data you are working with 
//View - user interface of the app
//Controller - code that sends model data to and from the view

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]() //changed [AnyObject] to String because we know we are only using Strings on this app


    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = NSFileManager.defaultManager() //look for files
        //where to look for files, we add ! because we are sure it will return a string and if we didnt add it we would have to add an unwrapping method for possible optionals
        let path = NSBundle.mainBundle().resourcePath!
        //items with look and where returns STRING on FILENAMES try! because we are certain the code will not fail, we do not need try catch methods then
        let items = try! fm.contentsOfDirectoryAtPath(path)
        
        for item in items { //treat items as a series of text strings, then pull out each one of those text strings, give it the name item, then run the following code block
            if item.hasPrefix("nssl")
            {
                objects.append(item) //adds matching filename to a list called objects that xCode creates
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*Deleting this

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    } */

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //prepareForSegue allows you to change a view before loading it 
                                                                                //or add customization befor ethe new controller is shown
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow { //we tell indexPAth to be what user selects
                /* replaced
                let object = objects[indexPath.row] //as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object */
                let navigationController = segue.destinationViewController as! UINavigationController //it is telling it the destination ocntroller after segue is a Navigatrion controller
                let controller = navigationController.topViewController as! DetailViewController //we override swift and tell hime our TopViewController is definetely DetalViewControl;ler
                controller.detailItem = objects[indexPath.row] //detailItem is the object of the selected row
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] //as! NSDate
        cell.textLabel!.text = object //.description we took this out because we know all the objects will be Strings, no need for description
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
/* Deleting this
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    } */


}

