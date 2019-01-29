//
//  notificationHandler.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 1/10/19.
//  Copyright © 2019 Surdracek. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class notificationHandler {
    
    let http = httpModel()
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func updateNotifID(user: String, notifID: String, completion:((Error?) -> Void)?) {
        //Initialize the URL session
        guard let url = URL(string: serverVars.serverHost + "/users/setNotifID") else
        {
            completion?(CredentialErrors.invalidURLSet)
            return
        }
        
        let credentials = notifPost(username: user, notifID: notifID)
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(credentials)
            
            let responseData = http.sendRequest(url: url, httpMethod: "POST", data: jsonData, headers: nil) {(error) in
                completion?(error)
            }
            let parsedData = try JSONSerialization.jsonObject(with: responseData, options: []) as Any
            print(parsedData)
        } catch {
            completion?(error)
        }
    }
    
    struct notifPost: Codable {
        let username: String
        let notifID: String
    }
    
    enum CredentialErrors: Error {
        case invalidURLSet
    }
}
