//
//  ItemListViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 7/9/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var array:[String] = ["Item1", "Item2", "Item3"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row]
        return cell
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
            let name = array[row]
            dest.name = name
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
