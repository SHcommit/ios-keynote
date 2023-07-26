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
  private var slideManager: (SlideManagerType & KeynoteSlideMenuDataSource)!
  
  private lazy var inputEvent = SlideManager.Input()
  
  private var subscriptions = Set<AnyCancellable>()
  
  // MARK: - Lifecycle
  init(slideManager: SlideManagerType & KeynoteSlideMenuDataSource) {
    super.init(nibName: nil, bundle: nil)
    self.slideManager = slideManager
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    keynoteView = KeynoteView(layoutFrom: view)
    missionWeek3_1()
    keynoteView.slideDatailViewDataSource = self
    bind()
  }
}

// MARK: - Private helper
private extension KeynoteViewController {
  func bind() {
    let output = slideManager.transform(input: inputEvent)
    
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

// MARK: - UITableViewDataSource
extension KeynoteViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return slideManager.numberOfItems
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    if tableView is SlideDetailView {
      guard
        let cell = tableView.dequeueReusableCell(
          withIdentifier: SlideDetailViewCell.id,
          for: indexPath) as? SlideDetailViewCell
      else { return .init(style: .default, reuseIdentifier: SlideMenuViewCell.id) }
      let item = slideManager.cellItem(at: indexPath.row)
      cell.configure(with: item)
      return cell
    }
    return .init(frame: .zero)
  }
}

fileprivate extension KeynoteViewController {
  func missionWeek3_1() {
    let rectModelFactory = RectModelFactory()
    let uniqueIdStorage = UniqueIdRandomGeneratorStorage
      .shared
    
    let rectModelDescriptions = (0..<4).map {
      let uniqueId = uniqueIdStorage.create(
        from: rectModelFactory)
      let rgb = rectModelFactory.makeRGBRandomValue()
      let alpha = rectModelFactory.makeAlphaRandomValue()
      
      let alphaModel = AlphaModel(alpha: alpha)
      
      let rgbaModel = RGBAModel(
        red: rgb.R,
        green: rgb.G,
        blue: rgb.B,
        alpha: alphaModel)
      let rectModel = RectModel(
        uniqueID: uniqueId,
        width: Int.random(in: 100...400),
        rgba: rgbaModel)
      return "Rect\($0+1) " + rectModel.description
    }
    rectModelDescriptions.forEach {
      os_log("%@",type: .default, $0)
    }
  }
}
