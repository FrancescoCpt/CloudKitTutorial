//
//  ViewController.swift
//  CloudKitTutorial
//
//  Created by Francesco Caputo on 06/03/18.
//  Copyright © 2018 Francesco Caputo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //istanciate CloudSync class
        let cloud = CloudSync()
        
        //get all users
        cloud.getAllUsers { (users) in
            
            //for each user print description
            for user in users {
                print(user.description())
            }
        }
    }
    
    @IBAction func createUser(_ sender: UIButton) {
        //create user
        self.user = User(name: "Giorgio", surname: "Maddaloni", age: 27, recordID: nil)
        
        //istanciate CloudSync class
        let cloud = CloudSync()
        
        //save user on cloud
        cloud.saveUser(user: self.user!)
    }
    
    @IBAction func updateUser(_ sender: UIButton) {
        //Exit from function if user is not set
        guard self.user != nil else { return }
        
        //update user name
        self.user!.name = "Francesco"
        
        //istanciate CloudSync class
        let cloud = CloudSync()
        
        //update user on cloud
        cloud.updateUser(user: self.user!)
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        
        //Exit from function if user is not set
        guard self.user != nil else { return }
        
        //istanciate CloudSync class
        let cloud = CloudSync()
        
        //update user on cloud
        cloud.deleteUser(user: self.user!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

