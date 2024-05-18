//
//  SettingView.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/18/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
      VStack {
        // TODO: - 타이틀 뷰
        TitleView()

        Spacer()
          .frame(height: 35)

        // TODO: - 총 탭 카운트 뷰
        TotalTabCountView()

        Spacer()
          .frame(height: 40)

        // TODO: - 총 탭 무브 뷰
        TotalTabMoveView()

        Spacer() // 하위 공간 확보
      }
    }
}

// MARK: - 타이틀뷰
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("설정")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(Color.customBlack)

      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 45)
  }
}

// MARK: - 전체 탭 설정된 카운트 뷰
private struct TotalTabCountView: View {
  fileprivate var body: some View {
    // 각각 탭 카운트 뷰 (todolist, 메모장, 음성메모)
    HStack {
      TabCountView(title: "To do", count: 0)
      Spacer()
        .frame(width: 70)
      TabCountView(title: "메모", count: 2)
      Spacer()
        .frame(width: 70)
      TabCountView(title: "음성메모", count: 3)
    }
  }
}

// MARK: - 각 탭 설정된 카운트 뷰 (공통 뷰 컴포넌트)
private struct TabCountView: View {
  private var title: String
  private var count: Int

  fileprivate init(
    title: String,
    count: Int
  ) {
    self.title = title
    self.count = count
  }

  fileprivate var body: some View {
    VStack(spacing: 5) {
      Text(title)
        .font(.system(size: 14))
        .foregroundStyle(Color.customBlack)

      Text("\(count)")
        .font(.system(size: 30, weight: .medium))
        .foregroundStyle(Color.customBlack)
    }
  }
}

// MARK: - 전체 탭 이동 뷰
private struct TotalTabMoveView: View {
  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(Color.customGray1)
        .frame(height: 1)

      // 각 탭 4개 이동 뷰 컴포넌트
      TabMoveView(
        title: "To do List",
        tabAction: {}
      )

      TabMoveView(
        title: "메모장",
        tabAction: {}
      )

      TabMoveView(
        title: "음성메모",
        tabAction: {}
      )

      TabMoveView(
        title: "타이머",
        tabAction: {}
      )

      Rectangle()
        .fill(Color.customGray1)
        .frame(height: 1)

    }
  }
}

// MARK: - 각 탭 이동 뷰
private struct TabMoveView: View {
  private var title: String
  private var tabAction: () -> Void

  fileprivate init(
    title: String,
    tabAction: @escaping () -> Void
  ) {
    self.title = title
    self.tabAction = tabAction
  }

  fileprivate var body: some View {
    Button {
      tabAction()
    } label: {
      HStack {
        Text(title)
          .font(.system(size: 14))
          .foregroundStyle(Color.customBlack)

        Spacer()

        Image("arrowRight")
      }
    }
    .padding(.all, 20)
  }
}

#Preview {
    SettingView()
}
