//
//  User.swift
//  CloudKitTutorial
//
//  Created by Francesco Caputo on 06/03/18.
//  Copyright © 2018 Francesco Caputo. All rights reserved.
//

import Foundation
import CloudKit

class User {
    var name: String
    var surname: String
    var age: Int
    var recordID: CKRecordID?
    
    init(name: String, surname: String, age: Int, recordID: CKRecordID?) {
        self.name = name
        self.surname = surname
        self.age = age
        self.recordID = recordID
    }
    
    func description() -> String {
        return "Name: \(name), Surname: \(surname), Age: \(age)"
    }
}
