//
//  ViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 6/22/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "segLoginView", sender: self);
        }
    }

    @IBAction func onLogout(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

