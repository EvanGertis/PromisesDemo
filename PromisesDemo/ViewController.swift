//
//  ViewController.swift
//  PromisesDemo
//
//  Created by Evan Gertis on 8/6/18.
//  Copyright © 2018 Evan Gertis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Test case.
    // username = "davidvtesting@outlook.com"
    // password = "MGUzsu4Y7cgJG"
    
    // UI variables
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the text on the login.
        LoginButton.setTitle("Login", for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // After the user enters the proper login and password an access token is assigned
    // to their user preferences.
    @IBAction func LoginButton(_ sender: Any) {

        // Read UItext fields and set them to local variables.
        let tUsername = _username.text
        let tPassword = _password.text
        
        let loginAssistant = LoginAssistant()
        
        // Guard against blank submission
        if(tUsername == "" || tPassword == ""){
            
            //TODO: replace with warning to user, throw exception.
            print("username or password fields were blank")
            return
        }
        
        loginAssistant.doLogin(tUsername!, tPassword!)
        
        if(UserDefaults.standard.string(forKey: "accessToken") != ""){
            print("second screen accessToken: \(UserDefaults.standard.string(forKey: "accessToken"))")
            print("we can proceed")
        }
    }
    

    

}

