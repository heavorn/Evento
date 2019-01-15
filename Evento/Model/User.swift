//
//  User.swift
//  Evento
//
//  Created by Sovorn on 12/1/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class User {
    let uid: String?
    let name: String?
    let profileUrl: String?
    let phone: String?
    let email: String?
    
    init(uid: String, dictionary: [String : Any]) {
        self.uid = uid
        self.name = dictionary["name"] as? String
        self.profileUrl = dictionary["profileUrl"] as? String
        self.phone = dictionary["phone"] as? String
        self.email = dictionary["email"] as? String
    }
}
