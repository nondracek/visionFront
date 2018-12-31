//
//  httpModel.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/27/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import Foundation

class httpModel {
    
    func sendRequest(url: URL, httpMethod: String, data: Data, completion:((Error?) -> Void)?) -> Data {
        var returnData = Data()
        let postCall = DispatchGroup()
        postCall.enter()
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 1000
        request.httpMethod = httpMethod
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let JWT = UserDefaults.standard.string(forKey: "authToken") {
            let headerToken = "Bearer ".appending(JWT)
            request.addValue(headerToken, forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError)
                postCall.leave()
                return
            }
            
            // APIs usually respond with the data you just sent in your POST request
            if let data = responseData {
                print(response)
                returnData = data
            }
            
            postCall.leave()
        }
        task.resume()
        
        postCall.wait()
        
        return returnData
    }
    
    func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
    func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
        }
        
        return payload
    }
}
