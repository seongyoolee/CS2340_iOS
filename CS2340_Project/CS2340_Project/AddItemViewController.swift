//
//  AddItemViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 7/1/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemNameText: UITextField! = UITextField()
    @IBOutlet weak var lostFoundText: UITextField! = UITextField()
    @IBOutlet weak var detailsText: UITextView! = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDone(_ sender: AnyObject) {
//        let itemName = itemNameText.text;
//        let lostFound = lostFoundText.text;
//        let details = detailsText.text;
        let userDefaults:UserDefaults = UserDefaults.standard
        
        var itemList:NSMutableArray? = (userDefaults.object(forKey: "itemList") as? NSMutableArray)!
        let dataSet: NSMutableDictionary? = NSMutableDictionary()
        
        dataSet?.setObject(itemNameText.text!, forKey: "itemName" as NSCopying)
        dataSet?.setObject(lostFoundText.text!, forKey: "lostFound" as NSCopying)
        dataSet?.setObject(detailsText.text, forKey: "details" as NSCopying)
        
        if (itemList != nil) {
            // data already available
            let newMutableList: NSMutableArray = NSMutableArray()
            
            for dict: Any in itemList! {
                newMutableList.add(dict as! NSDictionary)
            }
            
            userDefaults.removeObject(forKey: "itemList")
            newMutableList.add(dataSet!)
            userDefaults.set(newMutableList, forKey: "itemList")
        } else {
            // first item to be added to the list
            userDefaults.removeObject(forKey: "itemList")
            itemList = NSMutableArray()
            itemList!.add(dataSet!)
            userDefaults.set(itemList, forKey: "itemList")
        }
        
        userDefaults.synchronize()
        self.navigationController?.popToRootViewController(animated: true)

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
