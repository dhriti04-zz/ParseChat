//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Dhriti Chawla on 2/5/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    let alertController = UIAlertController(title: "Alert", message: "Username/Password is empty!", preferredStyle: .alert)

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print ("OK TAPPED")
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func SignUpUser(_ sender: Any) {
        
        let newUser = PFUser()
        
        if (passWordField.text=="" || userNameField.text=="" ){
            self.present(alertController, animated: true) {
                print ("ERROR")
            }}
        else {
        
        // set user properties
        newUser.username = userNameField.text
        newUser.password = passWordField.text
        
        
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                
                if (error._code == 202) {
                    let alertController = UIAlertController(title: "Alert", message: "Username is already taken!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("OK TAPPED")
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true) {
                        print ("ERROR")
                    }
                }
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
      }
    }
    
    @IBAction func LogInUser(_ sender: Any) {
        if (passWordField.text == "" || userNameField.text == "" ){
            self.present(alertController, animated: true) {
                print ("ERROR")
            }}
        else {
        let username = userNameField.text
        let password = passWordField.text
        
            PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                
                
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
      }
    }
}
