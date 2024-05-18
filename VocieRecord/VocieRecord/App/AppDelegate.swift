//
//  AppDelegate.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/19/24.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  var notificationDelegate = NotificationDelegate()

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = notificationDelegate
    return true
  }
}
