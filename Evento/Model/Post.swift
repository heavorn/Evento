//
//  Post.swift
//  Evento
//
//  Created by Sovorn on 12/3/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class Post {
    var id: String?
    let user: User?
    let name: String?
    let time: String?
    let month: String?
    let day: String?
    let location: String?
    let city: String?
    let phone: String?
    let type: String?
    let des: String?
    let eventUrl: String?
    var date: Date?
    
    init(dictionary: [String : Any], user: User) {
        self.user = user
        self.name = dictionary["name"] as? String
        self.time = dictionary["time"] as? String
        self.month = dictionary["month"] as? String
        self.day = dictionary["day"] as? String
        self.location = dictionary["location"] as? String
        self.city = dictionary["city"] as? String
        self.phone = dictionary["phone"] as? String
        self.type = dictionary["type"] as? String
        self.eventUrl = dictionary["eventUrl"] as? String
        self.des = dictionary["des"] as? String
        
    }
}
