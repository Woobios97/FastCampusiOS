//
//  File.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/19/24.
//

import Foundation

extension Double {
  var formattedTimeInterval: String {
    let totalSeconds = Int(self)
    let seconds = totalSeconds % 60
    let minutes = (totalSeconds / 60) % 60

    return String(format: "%02d:%02d", minutes, seconds)
  }
}
