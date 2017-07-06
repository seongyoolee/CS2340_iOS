//
//  ItemListTableViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 6/29/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController {
    
    // let arr = ["florida", "georgia", "alabama", "louisiana"]
    var itemsArr:NSMutableArray = NSMutableArray();
    
    override func viewDidAppear(_ animated: Bool) {
        let userDefaults:UserDefaults = UserDefaults.standard
        let itemListFromUserDefaults:NSMutableArray? = userDefaults.object(forKey: "itemList") as? NSMutableArray
        
        if ((itemListFromUserDefaults) != nil) {
            itemsArr = itemListFromUserDefaults!
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // return arr.count
        return itemsArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        // Configure the cell...
        let item:NSDictionary = itemsArr.object(at: indexPath.row) as! NSDictionary
        cell.textLabel?.text = item.object(forKey: "itemName") as? String
        
        // cell.textLabel!.text = arr[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "showDetail") {
            let selectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let detailViewController:ItemDetailViewController = segue.destination as! ItemDetailViewController
            
            detailViewController.itemData = itemsArr[selectedIndexPath.row] as! NSDictionary
        }
    }
    

}
