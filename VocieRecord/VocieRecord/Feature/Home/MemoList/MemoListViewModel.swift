//
//  MemoListViewModel.swift
//  VocieRecord
//
//  Created by 김우섭 on 5/1/24.
//
import Foundation

class MemoListViewModel: ObservableObject {
  @Published var memos: [Memo]
  @Published var isEditMemoMode: Bool
  @Published var removeMemos: [Memo]
  @Published var isDisplayRemoveMemoAlert: Bool

  // 제거될 메모의 수를 반환하는 계산된 프로퍼티입니다.
  var removeMemoCount: Int {
    return removeMemos.count
  }

  // 편집 모드의 활성화 여부에 따라 오른쪽 네비게이션 버튼의 타입을 결정하는 계산된 프로퍼티입니다.
  var navigationBarRightMode: NavigationBtnType {
    isEditMemoMode ? .complete : .edit
  }

  // 모델의 초기 상태를 설정하기 위한 초기화 함수입니다.
  init(
    memos: [Memo] = [],
    isEditMemoMode: Bool = false,
    removeMemos: [Memo] = [],
    isDisplayRemoveMemoAlert: Bool = false
  ) {
    self.memos = memos
    self.isEditMemoMode = isEditMemoMode
    self.removeMemos = removeMemos
    self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
  }
}

// 메모 작업과 관련된 함수를 조직하기 위한 확장입니다.
extension MemoListViewModel {
  // 리스트에 새 메모를 추가합니다.
  func addMemo(_ memo: Memo) {
    memos.append(memo)
  }

  // 리스트에 있는 특정 메모를 업데이트합니다.
  func updateMemo(_ memo: Memo) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
      memos[index] = memo
    }
  }

  // 리스트에서 특정 메모를 제거합니다.
  func removeMemo(_ memo: Memo) {
    if let index = memos.firstIndex(where: { $0.id == memo.id }) {
      // MARK: - firstIndex(of:)는 배열의 앞에서 부터 조회해서 첫번째 일치하는 값의 index를 반환한다.
      memos.remove(at: index)
    }
  }

  // 오른쪽 네비게이션 버튼이 탭될 때의 행동을 처리합니다: 편집 모드를 토글하거나, 삭제할 메모가 있으면 얼럿을 보여줍니다.
  func navigationRightBtnTapped() {
    if isEditMemoMode {
      if removeMemos.isEmpty {
        isEditMemoMode = false
      } else {
        setIsDisplayRemoveMemoAlert(true)
      }
    } else {
      isEditMemoMode = true
    }
  }

  // 삭제 메모 얼럿을 표시할지 여부를 설정합니다.
  func setIsDisplayRemoveMemoAlert(_ isDisplay: Bool) {
    isDisplayRemoveMemoAlert = isDisplay
  }

  // 제거를 위해 메모의 선택 상태를 토글합니다.
  // MARK: - memoRemoveSelectBoxTapped 함수는 특정 메모를 removeMemos 배열에 추가하거나 배열에서 제거함으로써, 해당 메모의 선택 상태를 토글(전환)합니다. 만약 메모가 이미 선택된 상태(즉, removeMemos 배열에 포함되어 있음)라면 그 메모를 배열에서 제거하고, 그렇지 않다면 배열에 추가합니다. 이 기능은 사용자가 UI에서 메모를 클릭하거나 선택하는 등의 상호작용을 통해 직접 조작할 수 있습니다.
  func memoRemoveSelectBoxTapped(_ memo: Memo) {
    if let index = removeMemos.firstIndex(of: memo) {
      removeMemos.remove(at: index)
    } else {
      removeMemos.append(memo)
    }
  }

  // 선택된 모든 메모를 리스트에서 제거하고 편집 모드를 리셋합니다.
  /*
   • 메모 삭제:
   memos.removeAll { memo in removeMemos.contains(memo) }는 memos 배열에서 removeMemos 배열에 포함된 모든 메모를
   삭제합니다. 여기서 removeAll(where:) 메서드는 조건에 해당하는 모든 요소를 memos 배열에서 제거합니다.
   removeMemos.contains(memo) 조건은 현재 처리 중인 memo가 removeMemos 배열에 포함되어 있는지를 확인합니다. 
   포함되어 있다면 해당 메모는 삭제 대상이므로 memos 배열에서 제거됩니다.
   • 선택 목록 초기화:
   removeMemos.removeAll()는 removeMemos 배열을 비워서 모든 선택 상태를 초기화합니다. 이는 사용자가 다시 삭제 모드에 들어갔을 때
   이전의 선택이 남아있지 않게 하기 위함입니다.
   • 편집 모드 해제:
   isEditMemoMode = false는 편집 모드를 비활성화합니다. 즉, 사용자가 삭제 작업을 완료하고 일반 보기 모드로 돌아가게 설정합니다.
   */
  func removeBtnTapped() {
    memos.removeAll { memo in
      removeMemos.contains(memo)
    }
    removeMemos.removeAll()
    isEditMemoMode = false
  }
}
