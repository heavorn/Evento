//
//  Setting.swift
//  Evento
//
//  Created by Sovorn on 11/22/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class Setting: NSObject {
    
    let imageName: String
    let titleName: String
    
    init(image: String, title: String) {
        self.imageName = image
        self.titleName = title
    }
}
