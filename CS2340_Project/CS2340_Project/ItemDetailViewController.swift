//
//  ItemDetailViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 7/1/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var itemNameText: UITextField! = UITextField()
    @IBOutlet weak var lostFoundText: UITextField! = UITextField()
    @IBOutlet weak var detailsText: UITextView! = UITextView()
    
    var itemData: NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemNameText.isUserInteractionEnabled = false
        lostFoundText.isUserInteractionEnabled = false
        detailsText.isUserInteractionEnabled = false
        
        itemNameText.text = itemData.object(forKey: "itemName") as? String
        lostFoundText.text = itemData.object(forKey: "lostFound") as? String
        detailsText.text = itemData.object(forKey: "details") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
