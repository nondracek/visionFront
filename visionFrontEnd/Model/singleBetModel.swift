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
            
            _ = http.sendRequest(url: url, httpMethod: "POST", data: jsonData, headers: nil) {(error) in
                completion?(error)
            }
            
        } catch {
            completion?(error)
        }
    }
    
    func getBets(userID: String, completion:((Error?) -> Void)?) -> [allBetReturn]? {
        guard let url = URL(string: serverVars.serverHost + "/bets/allSingles") else
        {
            completion?(SingleBetErrors.invalidURLSet)
            return nil
        }
        
        let headers = ["userID": userID]
        do {
            
            let betData = http.sendRequest(url: url, httpMethod: "GET", data: nil, headers: headers) {(error) in
                completion?(error)
            }
            
//            let json = try JSONSerialization.jsonObject(with: betData, options: []) as? Array<[String: Any]>
            let json = try JSONDecoder().decode([allBetReturn].self, from: betData)
            return json
            
        } catch {
            completion?(error)
            return nil
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

public struct allBetReturn: Codable {
    let title: String?
    //        let _id: String?
    //        let __v: Int?
    //        let submissions: Dictionary<String, String>?
    let creationTime: String?
    //        let creator: String?
    let amount: Float?
    let cancellations: Dictionary<String, Bool>?
    let status: String?
    let participants: Array<String>?
    //        let accepted: Dictionary<String, Int>?
}
