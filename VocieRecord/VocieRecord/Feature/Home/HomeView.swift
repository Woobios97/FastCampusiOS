//
//  HomeView.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/20/24.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var pathModel: PathModel
  @StateObject private var homeViewModel = HomeViewModel()

  var body: some View {
    ZStack {
      // 탭뷰
      TabView(selection: $homeViewModel.selectedTab) {
        TodoListView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .todoList
              ? "todoIcon_selected"
              : "todoIcon"
            )
          }
          .tag(Tab.todoList)

        MemoListView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .memo
              ? "memoIcon_selected"
              : "memoIcon"
            )
          }
          .tag(Tab.memo)

        VoiceRecorderView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .voiceRecorder
              ? "recordIcon_selected"
              : "recordIcon"
            )
          }
          .tag(Tab.voiceRecorder)

        TimerView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .timer
              ? "timerIcon_selected"
              : "timerIcon"
            )
          }
          .tag(Tab.timer)

        SettingView()
          .tabItem {
            Image(
              homeViewModel.selectedTab == .setting
              ? "settingIcon_selected"
              : "settingIcon"
            )
          }
          .tag(Tab.setting)
      }
      .environmentObject(homeViewModel)
      
      SeperatorLineView()
    }
  }
}

// MARK: - 구분선
private struct SeperatorLineView: View {
  fileprivate var body: some View {
    VStack {
      Spacer()

      Rectangle()
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .frame(height: 10)
        .padding(.bottom, 60)
    }
  }
}

#Preview {
  // MARK: 상위뷰, 즉 OnboardingView에서 preview를 보기 위해서는 environmentObject로 2가지 조건이 필요하다.
  /*
   TodoListViewModel에서 추후에 pathModel도 사용할 것이고, homeViewModel도 올릴 것이다.
   왜냐면?
   homeViewModel에서부터 Todo에서까지가 작성버튼을 누르면, Todo 작성할 것이 path에 쌓여가지고, 만들어질 것이다. 
   TodoListView를 관장하는 객체는 HomeView이다.
   즉, 상위는 HomeView이다.
   따라서, environmentObject로 Todo와 memo에 대해서 새로운 path 스택이 쌓일 수 있기 때문에,
   environmentObject로 1) TodoListViewModel 와 2)MemoListViewModel를 갖고 있어야 한다.
  */
  HomeView()
    .environmentObject(PathModel())
    .environmentObject(TodoListViewModel())
    .environmentObject(MemoListViewModel())
}
