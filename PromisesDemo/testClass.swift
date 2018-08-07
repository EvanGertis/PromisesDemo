//
//  testClass.swift
//  PromisesDemo
//
//  Created by Evan Gertis on 8/7/18.
//  Copyright © 2018 Evan Gertis. All rights reserved.
//

import Foundation

// TODO: to be removed after.
public class TestClass {
    
    // Use the username and password to retreive the authentication token for the user.
    func doLogin(_ username:String, _ password:String){
        let body = "data={\"username\":\"\(username)\",\"password\":\"\(password)\"}"
        let url = URL(string: "https://dev.autoglasscrm.com/app/auth/")!
        
        saveAuthToken( url: url, body: body)
    }
    
    // concatenates the url and HTTP body into post request. Returns JSON response.
    func saveAuthToken(url: URL, body:String){
        // do url stuff
        let url = URL(string: "https://dev.autoglasscrm.com/app/auth/")!
        
        // Instantiate request.
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _ :Data = data else {
                return
            }
            
            let  json:Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            // Retrieve the access token from the JSON object
            if let session_data = server_response["token"] as? String
            {
                // Set the accessToken in the user preferences
                let preferences = UserDefaults.standard
                if(preferences.string(forKey: "accessToken") == nil){
                    preferences.set(session_data, forKey: "accessToken")
                    print("first screen accessToken \(UserDefaults.standard.string(forKey: "accessToken"))")
                }
            }
            
        })
        
        task.resume()
    }

    
    
            
}
