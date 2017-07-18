//
//  LoginViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 6/22/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: AnyObject) {
        let username = usernameTextField.text;
        let password = passwordTextField.text;
        
        let usernameStored = UserDefaults.standard.string(forKey: "username");
        let passwordStored = UserDefaults.standard.string(forKey: "password");
        
        if(usernameStored == username && passwordStored == password)
        {
            // Login successful
            UserDefaults.standard.set(true, forKey:"isUserLoggedIn");
            UserDefaults.standard.synchronize();
            self.dismiss(animated: true, completion: nil);
        } else {
            let myAlert = UIAlertController(title:"Alert", message:"Login was unsuccessful. Try again.", preferredStyle: UIAlertControllerStyle.alert);
            
            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                self.dismiss(animated: true, completion:nil);
            }
            
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
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
