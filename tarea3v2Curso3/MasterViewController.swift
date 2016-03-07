//
//  MasterViewController.swift
//  tarea3v2Curso3
//
//  Created by Yolanda Martínez on 3/6/16.
//  Copyright © 2016 Yolanda Martínez. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, ProtocoloAgregar {

    var detailViewController: DetailViewController? = nil
    var objects = [NSDictionary]()


    override func viewDidLoad() {
        super.viewDidLoad()
   
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
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

/*    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
*/
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        else
        {
            if segue.identifier == "agregar"
            {
                let controller = segue.destinationViewController as! ViewControllerAgregar
                controller.delegado = self
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

        let object = objects[indexPath.row]
        cell.textLabel!.text = (object.valueForKey("titulo") as! String)
        
        let surl = object.valueForKey("urlFotoPortada") as! String
        
        if surl != ""
        {
        
            let urlImg = NSURL(string: surl)
            
            let imagenData = NSData(contentsOfURL: urlImg!)
            
            cell.imageView?.image = UIImage(data: imagenData!)
        }
        return cell
    }


    // MARK: - Metodos del protocolo agregar
    
    func agregaLibro(titulo : String, isbn : String, autores : String, urlFotoPortada : String)
    {
        
        let dic = NSDictionary(objects: [titulo, isbn, autores, urlFotoPortada], forKeys: ["titulo", "isbn", "autores", "urlFotoPortada"])
        objects.append(dic)
        tableView.reloadData()
    }
}

