//
//  MemoList.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/1/24.
//

import SwiftUI

struct MemoListView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var memoListViewModel: MemoListViewModel
  @EnvironmentObject private var homeViewModel: HomeViewModel

  var body: some View {
    ZStack {
      VStack {
        if !memoListViewModel.memos.isEmpty {
          CustomNavigationBar(
            isDisplayLeftBtn: false,
            rightBtnAction: {
              memoListViewModel.navigationRightBtnTapped()
            },
            rightBtnType: memoListViewModel.navigationBarRightMode
          )
        } else {
          Spacer()
            .frame(height: 30)
        }

        // 타이틀 뷰
        TitleView()
          .padding(.top, 20)

        // 안내 뷰 혹은 메모리스트 컨텐츠 뷰
        if memoListViewModel.memos.isEmpty {
          AnnouncementView()
        } else {
          MemoListContentView()
            .padding(.top, 20)
        }
      }

      // 메모 작성 버튼 뷰
      WriteMemoBtnView()
        .padding(.trailing, 20)
        .padding(.bottom, 50)
    }
    .alert(
      "메모 \(memoListViewModel.removeMemoCount)개 삭제하시겠습니까?",
      isPresented: $memoListViewModel.isDisplayRemoveMemoAlert
    ) {
      Button("삭제", role: .destructive) {
        memoListViewModel.removeBtnTapped()
      }
      Button("취소", role: .cancel) {}
    }
    .onChange(
      of: memoListViewModel.memos,
      perform: { memos in
        homeViewModel.setMemoCount(memos.count)
      }
    )
  }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
  @EnvironmentObject private var memoListViewModel: MemoListViewModel

  fileprivate var body: some View {
    HStack {
      if memoListViewModel.memos.isEmpty {
        Text("메모를\n추가해 보세요.")
      } else {
        Text("메모 \(memoListViewModel.memos.count)개가\n있습니다.")
      }

      Spacer()
    }
    .font(.system(size: 30, weight: .bold))
    .padding(.leading, 20)
  }
}

// MARK: - 안내 뷰
private struct AnnouncementView: View {
  fileprivate var body: some View {
    VStack(spacing: 15) {
      Spacer()

      Image("pencil")
        .renderingMode(.template)
      Text("\"퇴근 8시간 전 메모\"")
      Text("\"개발 하기 전 기획서 메모\"")
      Text("\"운동하러 가기 메모\"")

      Spacer()
    }
    .font(.system(size: 16))
    .foregroundStyle(Color.customGray2)
  }
}

// MARK: - 메모 리스트 컨텐츠 뷰
private struct MemoListContentView: View {
  @EnvironmentObject private var memoListViewModel: MemoListViewModel

  var body: some View {
    VStack {
      HStack {
        Text("메모 목록")
          .font(.system(size: 16, weight: .bold))
          .padding(.leading, 20)

        Spacer()
      }
      ScrollView(.vertical) {
        VStack(spacing: 0) {
          Rectangle()
            .fill(Color.customGray0)
            .frame(height: 1)

          ForEach(memoListViewModel.memos, id: \.self) { memo in
            // 메모 셀 뷰 호출
            MemoCellView(memo: memo)
          }
        }
      }
    }
  }
}

private struct MemoCellView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var memoListViewModel: MemoListViewModel
  @State private var isRemoveSelected: Bool
  private var memo: Memo

  fileprivate init(
    isRemoveSelected: Bool = false,
    memo: Memo
  ) {
    _isRemoveSelected = State(initialValue: isRemoveSelected)
    self.memo = memo
  }

  fileprivate var body: some View {
    Button {
      // TODO: - path 관련 메모 구현 필요
      pathModel.paths.append(.memoView(isCreateMode: false, memo: memo))
    } label: {
      VStack(spacing: 10) {
        HStack {
          VStack(alignment: .leading) {
            Text(memo.title)
              .lineLimit(1)
              .font(.system(size: 16))
              .foregroundStyle(Color.customBlack)

            Text(memo.convertedDate)
              .font(.system(size: 12))
              .foregroundStyle(Color.customIconGray)
          }

          Spacer()

          if memoListViewModel.isEditMemoMode {
            Button {
              isRemoveSelected.toggle()
              memoListViewModel.memoRemoveSelectBoxTapped(memo)
            } label: {
              isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
            }
          }
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)

        Rectangle()
          .fill(Color.customGray0)
          .frame(height: 1)
      }
    }
  }
}

// MARK: - 메모작성 버튼 뷰
private struct WriteMemoBtnView: View {
  @EnvironmentObject private var pathModel: PathModel

  fileprivate var body: some View {
    VStack {
      Spacer()

      HStack {
        Spacer()

        Button {
          // TODO: - 메모 뷰 구현 후 구현
          pathModel.paths.append(.memoView(isCreateMode: true, memo: nil))
        } label: {
          Image("writeBtn")
        }
      }
    }
  }
}



#Preview {
  MemoListView()
    .environmentObject(PathModel())
    .environmentObject(MemoListViewModel())
}
