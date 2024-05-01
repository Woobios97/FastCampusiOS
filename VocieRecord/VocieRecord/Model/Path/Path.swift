//
//  Path.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/20/24.
//

import Foundation

// PathModel은 우리가 감지를 할 것이기 때문에, ObservableObject 프로토콜을 따라야 한다.
class PathModel: ObservableObject {
  @Published var paths: [PathType]

  init(paths: [PathType] = []) {
    self.paths = paths
  }
}
