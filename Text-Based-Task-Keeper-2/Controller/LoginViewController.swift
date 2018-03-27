//
//  LoginViewController.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/19/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        sendLoginRequest(username: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
    }
    
    func sendLoginRequest(username: String, password: String) {
        let url = Constants.Config.baseURL
        /*
        let parameters = [
            "email": username,
            "password": password
        ]*/
        
        let parameters = [
            "user": [
                "email": username,
                "password": password,
            ]
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
            print("Content-Type: \(response.response?.allHeaderFields)")
            
            if response.result.isSuccess {
                UserDefaults.standard.set(true, forKey: "status")
                
                // save API AuthToken and ExpiryDate in Keychain
                if let authorizationHeader = Request.authorizationHeader(user: parameters["user"]!["email"]!, password: parameters["user"]!["password"]!) {
                    self.saveApiTokenInKeychain(tokenValue: authorizationHeader.value, tokenKey: authorizationHeader.key)
                    self.saveApiTokenInKeychain(tokenValue: username, tokenKey: "email")
                }
                
                // save user ID in Keychain
                //self.saveApiTokenInKeychain(tokenValue: "9", tokenKey: "userID")
                
                //Go to the main screen
                Switcher.updateDefaultScreen()
                
            } else {
                // Show error
                print("false")
                
                UserDefaults.standard.set(false, forKey: "status")
    
            }
        }
    }
    
    func saveApiTokenInKeychain(tokenValue: String, tokenKey: String) {
        print("Save API token")
        print("tokenKey:" + tokenKey)
        Constants.Auth.keychain[tokenKey] = tokenValue
    }
}

