//
//  ViewController.swift
//  PromisesDemo
//
//  Created by Evan Gertis on 8/6/18.
//  Copyright © 2018 Evan Gertis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // TODO: replace with user UITextFields.
    let username = "davidvtesting@outlook.com"
    let password = "MGUzsu4Y7cgJG"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onSubmit()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: replace with button action function
    func onSubmit() {
        
        // TODO: read UITextFields and assign them to local variables.
        // Code below needs to be replaced with uiTextField.text
        let tUsername = username
        let tPassword = password
        
        let loginHelper = TestClass()
        
        // Guard against blank submission
        if(tUsername == "" || tPassword == ""){
            
            //TODO: replace with warning to user, throw exception.
            print("username or password fields were blank")
            return
        }
        
        let authToken = loginHelper.getAuthenticationToken(tUsername, tPassword)
        print(authToken)
    }


}

