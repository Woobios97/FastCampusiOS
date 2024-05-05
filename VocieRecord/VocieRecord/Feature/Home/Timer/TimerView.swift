//
//  TimerView.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/5/24.
//

import SwiftUI

struct TimerView: View {
  @StateObject var timerViewModel = TimerViewModel()


  var body: some View {

    if timerViewModel.isDisplaySetTimeView {
      // 타이머 설정 뷰
      SetTimerView(timerViewModel: timerViewModel)
    } else {
      // 타이머 작동 뷰
      TimerOperationView(timerViewModel: timerViewModel)
    }
  }
}

// MARK: - 타이머 설정 뷰
private struct SetTimerView: View {
  @ObservedObject private var timerViewModel: TimerViewModel

  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }

  var body: some View {
    VStack {
      // 타이틀
      TitleView()

      Spacer()
        .frame(height: 50)

      // 타이머 피커 뷰
      TimerPickerView(timerViewModel: timerViewModel)

      Spacer()
        .frame(height: 30)

      // 설정하기 버튼 뷰
      TimerCreateBtnView(timerViewModel: timerViewModel)

      Spacer()
    }
  }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
  fileprivate var body: some View {
    HStack {
      Text("타이머")
        .font(.system(size: 30, weight: .bold))
        .foregroundStyle(Color.customBlack)

      Spacer()
    }
    .padding(.horizontal, 30)
    .padding(.top, 30)
  }
}

// MARK: - 타이머 피커 뷰
private struct TimerPickerView: View {
  @ObservedObject private var timerViewModel: TimerViewModel

  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }

  fileprivate var body: some View {
    VStack {
      Rectangle()
        .fill(Color.customGray2)
        .frame(height: 1)

      HStack {
        Picker("Hour", selection: $timerViewModel.time.hours) {
          ForEach(0..<24) { hour in
            Text("\(hour)시")
          }
        }

        Picker("Minute", selection: $timerViewModel.time.minutes) {
          ForEach(0..<60) { minute in
            Text("\(minute)분")
          }
        }

        Picker("Second", selection: $timerViewModel.time.seconds) {
          ForEach(0..<60) { second in
            Text("\(second)초")
          }
        }
      }
      .labelsHidden()
      .pickerStyle(.wheel)

      Rectangle()
        .fill(Color.customGray2)
        .frame(height: 1)
    }
  }
}

// MARK: - 타이머 생성 버튼 뷰
private struct TimerCreateBtnView: View {

  @ObservedObject private var timerViewModel: TimerViewModel

  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }

  fileprivate var body: some View {
    Button {
      timerViewModel.settingBtnTapped()
    } label: {
      Text("설정하기")
        .font(.system(size: 18, weight: .bold))
        .foregroundStyle(Color.customGreen)
    }
  }
}

// MARK: - 타이머 작동 뷰
private struct TimerOperationView: View {
  @ObservedObject private var timerViewModel: TimerViewModel

  fileprivate init(timerViewModel: TimerViewModel) {
    self.timerViewModel = timerViewModel
  }

  fileprivate var body: some View {
    VStack {
      ZStack {
        VStack {
          Text("\(timerViewModel.timeRemaining.formattedTimeString)")
            .font(.system(size: 28))
            .foregroundStyle(Color.customBlack)
            .monospaced() // 각 글자 간에 다른 Width를 가지지 않고, 고정된 폭을 갖기 위한 monospaced()

          HStack(alignment: .bottom) {
            Image(systemName: "bell.fill")

            Text("\(timerViewModel.time.convertedSeconds.formattedSettingTime)")
              .font(.system(size: 16))
              .foregroundStyle(Color.customBlack)
              .padding(.top, 10)
          }
        }

        Circle()
          .stroke(Color.customOrange, lineWidth: 6)
          .frame(width: 350)
      }
      Spacer()
        .frame(height: 10)

      HStack {
        Button {
          timerViewModel.cancelBtnTapped()
        } label: {
          Text("취소")
            .font(.system(size: 16))
            .foregroundStyle(Color.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 22)
            .background(
              Circle()
                .fill(Color.customGray2.opacity(0.3))
            )
        }

        Spacer()

        Button {
          timerViewModel.pauseOrRestartBtnTapped()
        } label: {
          Text(timerViewModel.isPaused ? "계속진행" : "일시정지")
            .font(.system(size: 14))
            .foregroundStyle(Color.customBlack)
            .padding(.vertical, 25)
            .padding(.horizontal, 7)
            .background(
              Circle()
                .fill(Color(red: 1, green: 0.75, blue: 0.52).opacity(0.3))
            )
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

#Preview {
  TimerView()
}
