//
//  ItemListViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 7/9/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit
import CoreData

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var pins:[Pin] = []
    
    var filteredData:[Pin] = []
    var isSearching:Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        loadPins()
    }
    
    func loadPins() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        do {
            self.pins = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        }
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var pin = pins[indexPath.row]
        
        if isSearching {
            pin = filteredData[indexPath.row]
        }
        cell.textLabel?.text = "[\(pin.lostOrFound ?? "")] \(pin.pinName ?? "")"
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredData = pins.filter({$0.pinName == searchBar.text})
            tableView.reloadData()
        }
    }

    @IBAction func onAdd(_ sender: Any) {
        self.performSegue(withIdentifier: "segItemDetail", sender: -1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segItemDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ItemDetailViewController
        dest.beforeViewController = self
        if (sender as! Int == -1) {
            //new name
            dest.isNewName = true
        } else {
            let row = sender as! Int
            let pin = pins[row]

            dest.pin = pin
            dest.isNewName = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
