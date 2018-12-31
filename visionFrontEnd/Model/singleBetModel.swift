//
//  userRequests.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/27/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import Foundation

class SingleBet {
    
    let http = httpModel()
    
    func createBet(creator: String, amount: Float, otherUser: String, title: String, completion:((Error?) -> Void)?) {
        guard let url = URL(string: serverVars.serverHost + "/bets/createSingle") else
        {
            completion?(SingleBetErrors.invalidURLSet)
            return
        }
        
        let newBet = betStruct(creator: creator, amount: amount, participant: otherUser, title: title, creationTime: Date())
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(newBet)
            
            _ = http.sendRequest(url: url, httpMethod: "POST", data: jsonData) {(error) in
                completion?(error)
            }
            
        } catch {
            completion?(error)
        }
    }
    
    func getBets(userID: String, completion:((Error?) -> Void)?) -> Any {
        guard let url = URL(string: serverVars.serverHost + "/bets/allSingles") else
        {
            completion?(SingleBetErrors.invalidURLSet)
            return []
        }
        
        let bodyData = getBet(user: userID)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(bodyData)
            
            let betData = http.sendRequest(url: url, httpMethod: "GET", data: jsonData) {(error) in
                completion?(error)
            }
//            let json = try JSONSerialization.jsonObject(with: betData, options: []) as Any
            
//            let json = try JSONSerialization.jsonObject(with: betData, options: []) as? Array<[String: Any]>
            print(String(data: betData, encoding: .utf8 ))
            
//            return betData
            return []
            
        } catch {
            completion?(error)
            return []
        }
    }
    
    struct betStruct: Codable {
        let creator: String
        let amount: Float
        let participant: String
        let title: String
        let creationTime: Date
    }

    struct getBet: Codable {
        let user: String
        
    }
    
    enum SingleBetErrors: Error {
        case invalidURLSet
    }
}
