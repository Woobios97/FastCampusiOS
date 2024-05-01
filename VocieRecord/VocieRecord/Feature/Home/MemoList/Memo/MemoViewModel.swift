//
//  MemoViewModel.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/1/24.
//

import Foundation

class MemoViewModel: ObservableObject {
  @Published var memo: Memo

  init(memo: Memo) {
    self.memo = memo
  }
}
