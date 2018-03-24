//
//  SettingViewController.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 3/24/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: navigation
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    // MARK: actions
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailAddressLabel.text = Constants.Auth.keychain[string: "email"]
    }
    
}
