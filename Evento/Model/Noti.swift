//
//  Noti.swift
//  Evento
//
//  Created by Sovorn Chea on 1/22/19.
//  Copyright © 2019 Sovorn. All rights reserved.
//

import UIKit

class Noti {
    var postName: String?
    var date: Date?
    var user: User?
    
    init(name: String, user: User, time: Any) {
        self.postName = name
        self.user = user
        let second = time as? Double
        self.date = NSDate(timeIntervalSince1970: second!) as Date
    }
}
