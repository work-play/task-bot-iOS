//
//  LoginViewController.swift
//  Text-Based-Task-Keeper-2
//
//  Created by Miki Nomura on 2/19/18.
//  Copyright © 2018 Miki Nomura. All rights reserved.
//

import UIKit
import Alamofire

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
        let url = "https://httpbin.org/post"
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
            if response.result.isSuccess {
                // Go back to the main screen
                
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as UIViewController
                self.present(viewController, animated: true, completion: nil)
                
            } else {
                // Show error
                
            }
        }
    }
}

