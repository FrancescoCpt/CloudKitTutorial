//
//  CloudSync.swift
//  CloudKitTutorial
//
//  Created by Francesco Caputo on 06/03/18.
//  Copyright © 2018 Francesco Caputo. All rights reserved.
//

import Foundation
import CloudKit

class CloudSync {
    
    var users: [User] = []
    
    func getAllUsers(handler: @escaping ([User]) -> Void) {
        //Get the default container "iCloud.(Bundle Identifier)"
        let container = CKContainer.default()
        
        //get the public database on iCloud
        let db = container.publicCloudDatabase
        
        //setup a predicate to perform query
        let predicate = NSPredicate(value: true)
        //let predicate = NSPredicate(format: "name == %@", "Francesco")
        //let predicate = NSPredicate(format: "name == %@ AND surname == %@", "Francesco", "Caputo")
        
        //create a query
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        
        //perform query
        db.perform(query, inZoneWith: nil) { (records, error) in
            
            //Handle occurred errors
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            //For cycle to read all records
            for record in records! {
                
                //Get single record information
                let name = record["name"] as! String
                let surname = record["surname"] as! String
                let age = record["age"] as! Int
                let recordID = record.recordID
                
                //Create user with fetched data
                let user = User(name: name, surname: surname, age: age, recordID: recordID)
                
                //Append new user in users array
                self.users.append(user)
            }
            
            //Return all users from closure
            handler(self.users)
        }
    }
    
    func saveUser(user: User) {
        //Get the default container "iCloud.(Bundle Identifier)"
        let container = CKContainer.default()
        
        //get the public database on iCloud
        let db = container.publicCloudDatabase
        
        //generate record
        //let record = CKRecord(recordType: "UserInfo", zoneID: <#T##CKRecordZoneID#>)
        let record = CKRecord(recordType: "UserInfo")
        
        //set all record's fields
        record["name"] = user.name as CKRecordValue
        record["surname"] = user.surname as CKRecordValue
        record["age"] = user.age as CKRecordValue
        
        //Save record on public database
        db.save(record) { (record, error) in
            //handle occurred errors
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            //save record id after save on database
            user.recordID = record?.recordID
        }
    }
    
    func updateUser(user: User) {
        //Get the default container "iCloud.(Bundle Identifier)"
        let container = CKContainer.default()
        
        //get the public database on iCloud
        let db = container.publicCloudDatabase
        
        //Fetch record with specific record id
        db.fetch(withRecordID: user.recordID!) { (record, error) in
            
            //Handle occurred errors
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            //update the fetched record
            record!["name"] = user.name as CKRecordValue
            record!["surname"] = user.surname as CKRecordValue
            record!["age"] = user.age as CKRecordValue
            
            //Save the record update on database
            db.save(record!, completionHandler: { (record, error) in
                //Handle occurred errors
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
            })
        }
    }
    
    func deleteUser(user: User) {
        //Get the default container "iCloud.(Bundle Identifier)"
        let container = CKContainer.default()
        
        //get the public database on iCloud
        let db = container.publicCloudDatabase
        
        db.delete(withRecordID: user.recordID!) { (record, error) in
            
            //Handle occurred errors
            guard error == nil else {
                print(error.debugDescription)
                return
            }
        }
    }
}