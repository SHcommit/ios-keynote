//
//  KeynoteViewController.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit
import OSLog
import Combine

class KeynoteViewController: UIViewController {
  // MARK: - UI Properties
  private var keynoteView: KeynoteView! 
  
  // MARK: - Properties
  private var slideManager: (
    SlideManagerType & KeynoteViewAdapterDataSource)!
  
  private let appear = PassthroughSubject<Void,Never>()
  
  private var subscriptions = Set<AnyCancellable>()
  
  private var keynoteAdapter: KeynoteViewAdapter!
  
  private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  // MARK: - Lifecycle
  init(slideManager:
       SlideManagerType & KeynoteViewAdapterDataSource
  ) {
    super.init(nibName: nil, bundle: nil)
    self.slideManager = slideManager
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    // TODO: - SlideManager 인스턴스 할당받아야 합니다!!
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    keynoteView = KeynoteView(layoutFrom: view)
    missionWeek3_1()
    bind()
    keynoteAdapter = .init(
      dataSource: slideManager,
      delegate: keynoteView,
      slideMenuViewDataSource: &keynoteView.slideMenuViewDataSource,
      slideMenuViewDelegate: &keynoteView.slideMenuViewDelegate)
  }
}

// MARK: - Private helper
private extension KeynoteViewController {
  func bind() {
    let input = SlideManager.Input(appear: appear.eraseToAnyPublisher())
    let output = slideManager.transform(input: input)
    
    output.sink { [weak self] in
      self?.render($0)
    }.store(in: &subscriptions)
  }
  
  private func render(_ state: SlideManager.State) {
    switch state {
    case .none:
      break
    }
  }
}
