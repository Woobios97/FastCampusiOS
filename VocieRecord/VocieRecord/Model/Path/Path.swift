//
//  Path.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/20/24.
//

import Foundation

// PathType으로도 구분을 지어줘야 하니까 Hashable을 따라야한다?
// 즉, 구분이 필요한 것은 Hashable 프로토콜을 따르는 것이 좋다?
enum PathType: Hashable {
  case homeView
  case todoView
  case memoView
}
