//
//  ItemDetailViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 7/9/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var beforeViewController:ItemListViewController!
    var name: String = ""
    var isNewName: Bool = false

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = name
        
        if isNewName {
            promptLabel.text = "Enter a new name:"
        } else {
            promptLabel.text = "Edit name:"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDone(_ sender: Any) {
        if isNewName {
            beforeViewController.array.append(nameTextField.text!)
        } else {
            let i = beforeViewController.array.index(of: name)!
            beforeViewController.array[i] = nameTextField.text!
        }
        beforeViewController.tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
