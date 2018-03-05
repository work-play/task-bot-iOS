//
//  Message.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/25/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import Foundation

struct Message {
    let message: String
    let isSender: Bool
    
    init(message: String, isSender: Bool) {
        self.message = message
        self.isSender = isSender
    }
}
