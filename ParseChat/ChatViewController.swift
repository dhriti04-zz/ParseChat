//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Dhriti Chawla on 2/5/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var myMessages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground(){
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                //print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.myMessages = objects
                }
            } else {
                // Log details of the failure
                print(error?.localizedDescription)
            }
        
        }
        self.tableView.reloadData()
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        PFUser.logOut()
        let currentUser = PFUser.current()
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func pressSendButton(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["username"] = PFUser.current()!.username
        chatMessage["text"] = myTextField.text ?? ""

        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                
                self.myTextField.text!.removeAll()
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var message = myMessages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.myLabel.text = message["text"] as! String!
        cell.myUser.text = message["username"] as! String!
        
        return cell
    }
   
    
    
}
