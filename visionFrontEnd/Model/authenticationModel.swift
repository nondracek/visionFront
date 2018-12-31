//
//  authentication.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/25/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import Foundation

class Authentication {
    
    let http = httpModel()
    
    func logUserIn(user: String, pass: String, completion:((Error?) -> Void)?) {
        //Initialize the URL session
        guard let url = URL(string: serverVars.serverHost + "/users/login") else
        {
            completion?(CredentialErrors.invalidURLSet)
            return
        }
        
        let credentials = logInPost(username: user, password: pass)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            
            let responseData = http.sendRequest(url: url, httpMethod: "POST", data: jsonData) {(error) in
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
    
    func userSignUp(user: String, pass: String, email: String, completion:((Error?) -> Void)?) {
        
        //Initialize the URL session
        guard let url = URL(string: serverVars.serverHost + "/users/signup") else
        {
            completion?(CredentialErrors.invalidURLSet)
            return
        }
        
        let credentials = signUpPost(username: email, name: user, password: pass)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            
            let responseData = http.sendRequest(url: url, httpMethod: "POST", data: jsonData) {(error) in
                completion?(error)
            }
            
            let parsedData = try JSONDecoder().decode(serverReturn.self, from: responseData)
            UserDefaults.standard.set(parsedData.token, forKey: "authToken")
            
        } catch {
            completion?(error)
        }
    }
    
    struct logInPost: Codable {
        let username: String
        let password: String
    }
    
    struct signUpPost: Codable {
        let username: String
        let name: String
        let password: String
    }
    
    struct serverReturn: Codable {
        let token: String
    }
    
    enum CredentialErrors: Error {
        case invalidURLSet
    }
}
