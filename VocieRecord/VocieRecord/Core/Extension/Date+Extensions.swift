//
//  Date+Extensions.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/19/24.
//

import Foundation

extension Date {
  
  /// 시간 포맷
  var formattedTime: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "a hh:mm"
    return formatter.string(from: self)
  }
  
  /// 날짜 포맷
  var formattedDay: String {
    let now = Date()
    let calendar = Calendar.current

    let nowStartOfDay = calendar.startOfDay(for: now)
    let dateStartOfDay = calendar.startOfDay(for: self)
    let numOfDayDifference = calendar.dateComponents([.day], from: nowStartOfDay, to: dateStartOfDay).day!

    if numOfDayDifference == 0 {
      return "오늘"
    } else {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "ko_KR")
      formatter.dateFormat = "M월 d일 E요일"
      return formatter.string(from: self)
    }
  }
  
  // VoiceRecord 시간 포맷
  var formattedVoiceRecordTime: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy.M.d"
    return formatter.string(from: self)
  }
}
