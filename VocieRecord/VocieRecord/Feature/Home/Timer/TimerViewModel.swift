//
//  TimerViewModel.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/5/24.
//

import SwiftUI

class TimerViewModel: ObservableObject {
  @Published var isDisplaySetTimeView: Bool
  // 타이머는 두 view를 갖고 있기 때문에, hidden 처리해주는 것처럼 bool타입으로 두 view를 구분한다.
  @Published var time: Time
  @Published var timer: Timer?
  @Published var timeRemaining: Int
  @Published var isPaused: Bool
  var notificationService: NotificationService

  init(
    isDisplaySetTimeView: Bool = true,
    time: Time = .init(hours: 0, minutes: 0, seconds: 0),
    timer: Timer? = nil,
    timeRemaining: Int = 0,
    isPaused: Bool = false,
    notificationService: NotificationService = .init()
  ) {
    self.isDisplaySetTimeView = isDisplaySetTimeView
    self.time = time
    self.timer = timer
    self.timeRemaining = timeRemaining
    self.isPaused = isPaused
    self.notificationService = notificationService
  }
}

extension TimerViewModel {

  // MARK: - 밑의 함수들은 View와 상호작용하고 있어, private은 아니다.
  func settingBtnTapped() {
    isDisplaySetTimeView = false
    timeRemaining = time.convertedSeconds
    // TODO: - 타이머 시작 메서드 호출!
    startTimer()
  }

  func cancelBtnTapped() {
    // TODO: - 타이머 종료 메서드 호출!
    stopTimer()
    isDisplaySetTimeView = true
  }

  func pauseOrRestartBtnTapped() {
    if isPaused {
      // TODO: - 타이머 시작 메서드 호출!
      startTimer()
    } else {
      timer?.invalidate()
      timer = nil
    }
    isPaused.toggle()
  }
}

// MARK: - 타이머 시작과 타이머 종료 메서드는 ViewModel만 상호작용하기 때문에, extension을 하더라도, private를 붙인다.
private extension TimerViewModel {
  func startTimer() {
    guard timer == nil else { return }

    var backgroundTaskID: UIBackgroundTaskIdentifier? // -> 백그라운드 작업을 추적하기 위한 변수 선언, 초기값은 nil
    backgroundTaskID = UIApplication.shared.beginBackgroundTask {
      // 앱이 백그라운드로 전환됐을 때, 작업을 계속 진행할 수록 도와주는 메서드
      if let task = backgroundTaskID {
        UIApplication.shared.endBackgroundTask(task)
        backgroundTaskID = .invalid
      }
    }

    // 시간이 흐를 때마다 어떤 것을 해줄 것인지 정의
    timer = Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true) { _ in
        if self.timeRemaining > 0 { // 시간이 남았다면,
          self.timeRemaining -= 1
        } else {
          // 시간이 없다면,
          // TODO: - 타이머 종료 메서드 호출!
          self.stopTimer()
          self.notificationService.sendNotification()

          if let task = backgroundTaskID {
            UIApplication.shared.endBackgroundTask(task)
            backgroundTaskID = .invalid
          }
        }
      }
  }

  func stopTimer() {
    timer?.invalidate()
    timer = nil
  }
}
