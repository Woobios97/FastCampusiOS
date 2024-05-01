//
//  Memo.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/1/24.
//

import Foundation

struct Memo: Hashable {
  var title: String
  var content: String
  var date: Date
  var id = UUID()

  var convertedDate: String {
    String("\(date.formattedDay) - \(date.formattedTime)")
  }
}
