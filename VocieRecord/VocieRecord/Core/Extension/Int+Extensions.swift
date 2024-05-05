//
//  Int+.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/19/24.
//

import Foundation

extension Int {
  var formattedTimeString: String {
    let time = Time.fromSeconds(self)
    let hoursString = String(format: "%02d", time.hours)
    let minutesString = String(format: "%02d", time.minutes)
    let secondsString = String(format: "%02d", time.seconds)

    return "\(hoursString) : \(minutesString) : \(secondsString)"
  }

  var formattedSettingTime: String {  // 계산된 속성을 정의합니다. 이 속성은 문자열을 반환하며, 현재 시간에 Int 값(초)을 더한 시각을 "HH:mm" 형식으로 포맷합니다.
    let currentDate = Date()  // 현재 시간과 날짜를 나타내는 Date 객체를 생성하고, 이를 currentDate 변수에 할당합니다.
    let settingDate = currentDate.addingTimeInterval(TimeInterval(self))
    // currentDate에 self (Int 타입의 초 단위 값) 만큼의 시간을 더합니다. TimeInterval은 Double 타입이므로 Int를 TimeInterval로 변환합니다. 그 결과를 settingDate 변수에 저장합니다.

    let formatter = DateFormatter()  // 날짜와 시간을 텍스트로 변환하기 위한 DateFormatter 객체를 생성합니다.
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.dateFormat = "HH:mm"

    let formattedTime = formatter.string(from: settingDate)
    // settingDate (미래 시간)을 위에서 설정한 형식("HH:mm")에 따라 문자열로 변환하고, 이를 formattedTime 변수에 저장합니다.
    return formattedTime  // 변환된 문자열을 반환합니다. 이 문자열은 현재 시간으로부터 self 초 후의 시각을 "HH:mm" 형식으로 나타냅니다.
  }

}
