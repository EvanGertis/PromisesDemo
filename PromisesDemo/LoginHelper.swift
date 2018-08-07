//
//  LoginHelper.swift
//  PromisesDemo
//
//  Created by Evan Gertis on 8/6/18.
//  Copyright © 2018 Evan Gertis. All rights reserved.
//

import Foundation
import PromiseKit

public class LoginHelper {

    // Use the username and password to retreive the authentication token for the user.
    func getAuthenticationToken(username:String, password:String) -> String {
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
        print("authToken: \(authToken)") //f05e7c95c0e94fdcb7b984d276a7eada
        return authToken
    }

    // Use the authentication token and number of jobs to request job selection.
    func getJobs(authenticationToken: String, numberOfJobs:Int) -> [String]{
        let body = "data={\"token\":\"\(authenticationToken)\",\"viewjobs\":\"\(numberOfJobs)\""
        let url = URL(string: "https://dev.autoglasscrm.com/app/auth/")!
        
        // Instantiate request.
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let response = postToURL(url: url, body: body)
        return parseJobs(json: response)
    }


    // Parse the string of jobs from getJobs.
    func parseJobs(json: [String: Any]) -> [String] {
        // do parsing stuff
        
        guard let jobs = json["viewjobs"] as? [String] else{
            print("could not get JSON from response as dictionary, error parsing jobs")
            return [""]
        }
        return jobs
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
        request.httpBody = body.data(using: .utf8)
    
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            // If there was an error then print it out to the debugger and end the attempt.
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                
                guard let responseObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{
                    print("could not get JSON from responseData as dictionary")
                    return
                }
                
                responseDictionary = responseObject
                
                self.parseAuthenticationToken(json: responseDictionary)
            } catch {
                
                print("error parsing string")
            }
        }
        
        task.resume()
        
        return responseDictionary
    }

}
