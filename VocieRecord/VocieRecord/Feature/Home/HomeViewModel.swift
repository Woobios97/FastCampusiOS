//
//  HomeViewMode.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/18/24.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var selectedTab: Tab
  @Published var todosCount: Int
  @Published var memosCount: Int
  @Published var voiceRecorderCount: Int

  init(
    selectedTab: Tab = .voiceRecorder,
    todosCount: Int = 0,
    memosCount: Int = 0,
    voiceRecorderCount: Int = 0
  ) {
    self.selectedTab = selectedTab
    self.todosCount = todosCount
    self.memosCount = memosCount
    self.voiceRecorderCount = voiceRecorderCount
  }
}

extension HomeViewModel {
  // 3가지는 -> TodosCount~VoiceRecorderCount 갯수 변경
  func setTodosCount(_ count: Int) {
    todosCount = count
  }

  func setMemoCount(_ count: Int) {
    memosCount = count
  }

  func setVoiceRecordersCount(_ count: Int) {
    voiceRecorderCount = count
  }

  // Tab 변경 메서드
  // MARK: Tab들은 Item들이 고유해서 Home 화면에서는 Tab의 Item들을 눌러서 바꿀 수 있지만, 설정에서 각 Tab을 이동하는 기능이 있기 때문에,
  func changeSelectedTab(_ tab: Tab) {
    selectedTab = tab
  }
}
