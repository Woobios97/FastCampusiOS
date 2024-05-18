//
//  NotificationService.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/5/24.
//

import UserNotifications

struct NotificationService {
  func sendNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
      if granted {
        let content = UNMutableNotificationContent()
        content.title = "타이머 종료!"
        content.body = "설정한 타이머가 종료되었습니다."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(
          identifier: UUID().uuidString,
          content: content,
          trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
      }
      // MARK: - 알람설정 허용 즉, granted의 else , 알람설정을 안했다면 앱의 설정 중 알람까지 가게 코드를 작성할 수도 있다,
    }
  }
}

// MARK: - 실제로 보내고, Notification이 떴을 때, completionHandler를 받아야 한다.
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate { // NSObject를 왜 상속받는 지?
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.banner, .sound])
  }
}
