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
    func getAuthenticationToken(_ username:String, _ password:String) -> String {
        let body = "data={\"username\":\"\(username)\",\"password\":\"\(password)\"}"
        let url = URL(string: "https://dev.autoglasscrm.com/app/auth/")!
        
        let response = postToURL( url: url, body: body)
        return parseAuthenticationToken(json: response)
    }
    
    // Parse the Authentication token from the getAuthentiactionToken call.
    func parseAuthenticationToken(json: [String: Any]) -> String{
        // do parsing stuff
        
        guard let authToken = json["token"] as? String else{
            print("could not get JSON from responseData as dictionary, error parsing authentication token")
            return "error parsing authentication token"
        }
    
        return authToken
    }
    
    // concatenates the url and HTTP body into post request. Returns JSON response.
    func postToURL(url: URL, body:String) -> [String: Any]{
        // do url stuff
        var responseDictionary = [String: Any]()
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
            
            // TODO: replace specific retrevial of token with generic key.
            if let session_data = server_response["token"] as? String
            {
                let prefernces = UserDefaults.standard
                prefernces.set(session_data, forKey: "session")
                
                DispatchQueue.main.async {
                    self.LoginDone()
                    // DEBUG PRINT //
                    print("session_data: \(session_data)") //f05e7c95c0e94fdcb7b984d276a7eada
                    // DEBUG PRINT //
                }
            }
            
        })
        
        task.resume()
        
        // TODO: replace with return json object.
        return responseDictionary
    }
    
    func LoginDone(){
        
        print("login was successfully completed")
        
    }
    
    
            
}
