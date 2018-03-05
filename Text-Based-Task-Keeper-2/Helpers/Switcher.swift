//
//  Switcher.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 3/4/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    static func updateDefaultScreen() {
        let status = UserDefaults.standard.bool(forKey: "status")
        var defaultScreen: UIViewController?
        
        if status == true {
            defaultScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "collectionViewController") as! CollectionViewController
        } else {
            defaultScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = defaultScreen
    }
}
