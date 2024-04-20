//
//  OnboardingView.swift
//  VocieRecord
//
//  Created by 김우섭 on 4/19/24.
//

import SwiftUI

struct OnboardingView: View {
  @StateObject private var onboardingViewModel = OnboardingViewModel()

  var body: some View {
    // TODO: - 화면 전환 구현 필요
    OnboardingContentView(onboardingViewModel: onboardingViewModel)
  }
}

// MARK: - 온보딩 컨텐츠 뷰
private struct OnboardingContentView : View {
  @ObservedObject private var onboardingViewModel: OnboardingViewModel

  fileprivate init(onboardingViewModel: OnboardingViewModel) {
    self.onboardingViewModel = onboardingViewModel
  }

  fileprivate var body: some View {
    VStack {
      // 온보딩 셀리스트 뷰
      OnboardingCellListView(onboardingViewModel: onboardingViewModel)

      Spacer()

      // 시작 버튼 뷰
      StartBtnView()
    }
    .edgesIgnoringSafeArea(.top)
  }
}

// MARK: - 온보딩 셀 리스트 뷰
private struct OnboardingCellListView: View {
  @ObservedObject private var onboardingViewModel: OnboardingViewModel
  @State private var selectedIndex = 0

  fileprivate init(
    onboardingViewModel: OnboardingViewModel,
    selectedIndex: Int = 0
  ) {
    self.onboardingViewModel = onboardingViewModel
    self.selectedIndex = selectedIndex
  }

  fileprivate var body: some View {
    TabView(selection: $selectedIndex) {
      // 온보딩 셀
      /*
       요구사항
       - 탭뷰를 구현해서, 온보딩 카드뷰를 만들어야 한다.
       - 온보딩 컨텐츠 뷰 안에 온보딩 셀 리스트 뷰를 만든다.
       - 온보딩 셀리스트 뷰는 온보딩 뷰모델을 바라보고 있다.
       - 온보딩 카드뷰를 만들기 위해서 온보딩모델인 온보딩컨텐츠를 각 인덱스에 알맞게 배치해야한다.
       - 온보딩뷰모델의 온보딩컨텐츠의 인덱스를 알아내서, 배치를 해야된다.
       해결
       - TabView의 selection을 이용해서 ForEach를 배치한다. 각 인덱스에 맞게 모델의 컨텐츠와 인덱스를 배치해야한다.
       - 그래서 온보딩뷰모델의 온보딩컨텐츠를 배열로 만들고, enumerated와 indices를 이용해서 배치할 수 있다.
       */

      /// enumerated 방법
//      ForEach(Array(onboardingViewModel.OnboardingContents.enumerated()), id: \.element) { index, onboardingContent in
//        OnboardingCellView(onboardingContent: onboardingContent)
//          .tag(index)
//      }

      /// indices 방법
      ForEach(onboardingViewModel.OnboardingContents.indices, id: \.self) { index in
        let onboardingContents = onboardingViewModel.OnboardingContents[index]
        OnboardingCellView(onboardingContent: onboardingContents)
          .tag(index)
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
    .background(
      selectedIndex % 2 == 0 ? Color.customSky : Color.customBackgroundGreen
    )
    .clipped()
  }
}

// MARK: - 온보딩 셀 뷰
private struct OnboardingCellView: View {

  private var onboardingContent: OnboardingContent

  fileprivate init(onboardingContent: OnboardingContent) {
    self.onboardingContent = onboardingContent
  }

  fileprivate var body: some View {
    VStack {
      Image(onboardingContent.imageFileName)
        .resizable()
        .scaledToFit()

      HStack {
        Spacer()

        VStack {
          Spacer()
            .frame(height: 46)

          Text(onboardingContent.title)
            .font(.system(size: 16, weight: .bold))

          Spacer()
            .frame(height: 5)

          Text(onboardingContent.subTitle)
            .font(.system(size: 16))

        }
        Spacer()
      }
      .background(Color.customWhite)
      .cornerRadius(0)
    }
    .shadow(radius: 10)
  }
}

// MARK: - 시작하기 버튼 뷰
private struct StartBtnView: View {
  fileprivate var body: some View {
    Button {

    } label: {
      HStack {
        Text("시작하기")
          .font(.system(size: 17, weight: .medium))
          .foregroundStyle(Color.customGreen)

        Image("startHome")
          .renderingMode(.template) // 렌더링 모드 템플릿은 뭔데?
          .foregroundStyle(Color.customGreen)
      }
    }
    .padding(.bottom, 50)
  }

  func loadPackgae () {
    
  }
}

#Preview {
  OnboardingView()
}
