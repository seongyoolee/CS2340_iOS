//
//  RegisterPageViewController.swift
//  CS2340_Project
//
//  Created by Seon Gyoo Lee on 6/22/17.
//  Copyright © 2017 slee3056. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var userID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onRegister(_ sender: AnyObject) {
        let username = usernameTextField.text;
        let password = passwordTextField.text;
        let repeatPassword = repeatPasswordTextField.text;
        
        //check for empty fields
        if((username?.isEmpty)! || (password?.isEmpty)! || (repeatPassword?.isEmpty)!)
        {
            //display alert message
            displayAlertMessage(userMessage: "All fields are required.");
            return;
        }
        
        //check if passwords match
        if(password != repeatPassword)
        {
            //display alert message
            displayAlertMessage(userMessage: "Passwords do not match.")
            return;
        }
        
        //store data
        UserDefaults.standard.set(username, forKey:"username");
        UserDefaults.standard.set(password, forKey:"password");
        UserDefaults.standard.synchronize();
        
        //display alert message with confirmation
        let myAlert = UIAlertController(title:"Alert", message:"Registration was successful. Thank you!", preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
            self.dismiss(animated: true, completion:nil);
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    func displayAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
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
