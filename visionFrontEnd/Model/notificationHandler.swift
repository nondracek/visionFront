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
}
