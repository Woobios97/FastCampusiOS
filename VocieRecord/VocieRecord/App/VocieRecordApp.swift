//
//  VocieRecordApp.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/19/24.
//

import SwiftUI

@main
struct VocieRecordApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      OnboardingView()
    }
  }
}
