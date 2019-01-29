//
//  authentication.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/25/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import Foundation
import UIKit

class Authentication {
    
    let http = httpModel()
    
    func logUserIn(user: String, pass: String, deviceID: String, completion:((Error?) -> Void)?) {
        //Initialize the URL session
        guard let url = URL(string: serverVars.serverHost + "/users/login") else
        {
            completion?(CredentialErrors.invalidURLSet)
            return
        }
        
        let credentials = logInPost(username: user, password: pass, deviceToken: deviceID)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            
            let responseData = http.sendRequest(url: url, httpMethod: "POST", data: jsonData, headers: nil) {(error) in
                completion?(error)
            }
            let parsedData = try JSONDecoder().decode(serverReturn.self, from: responseData)
            let decodedString = http.decode(jwtToken: parsedData.token)
            
            UserDefaults.standard.set(decodedString["_id"], forKey: "userID")
            UserDefaults.standard.set(parsedData.token, forKey: "authToken")
        } catch {
            completion?(error)
        }
    }
    
    func userSignUp(user: String, pass: String, email: String, deviceID: String, completion:((Error?) -> Void)?) {
        
        //Initialize the URL session
        guard let url = URL(string: serverVars.serverHost + "/users/signup") else
        {
            completion?(CredentialErrors.invalidURLSet)
            return
        }
        
        let credentials = signUpPost(username: email, name: user, password: pass, deviceToken: deviceID)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            
            let responseData = http.sendRequest(url: url, httpMethod: "POST", data: jsonData, headers: nil) {(error) in
                completion?(error)
            }
            
            let parsedData = try JSONDecoder().decode(serverReturn.self, from: responseData)
            UserDefaults.standard.set(parsedData.token, forKey: "authToken")
            
        } catch {
            completion?(error)
        }
    }
    
    func getDeviceID() -> String? {
        if let ID = UIDevice.current.identifierForVendor {
//            let tokenParts = ID.map { data in String(format: "%02.2hhx", data) }
//            let token = tokenParts.joined()
            return "blah"
        } else {
            return nil
        }
    }
    
    struct logInPost: Codable {
        let username: String
        let password: String
        let deviceToken: String
    }
    
    struct signUpPost: Codable {
        let username: String
        let name: String
        let password: String
        let deviceToken: String
    }
    
    struct serverReturn: Codable {
        let token: String
    }
    
    enum CredentialErrors: Error {
        case invalidURLSet
    }
}
