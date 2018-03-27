//
//  Constant.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/25/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import Foundation
import KeychainAccess

struct Constants {
    enum Config {
        static let baseURL: String = "https://ancient-sea-46887.herokuapp.com/api/v1"
    }
    
    enum Auth {
        static let keychain = Keychain(service: "com.example.github-token")
    }
}
