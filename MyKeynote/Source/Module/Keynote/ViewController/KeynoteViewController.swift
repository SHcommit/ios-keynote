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
  // MARK: - Properties
  private let keynoteView = KeynoteView()
  
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
  
  override func loadView() {
    view = keynoteView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    missionWeek3_1()
    keynoteView.slideDatailViewDataSource = self
    bind()
  }
  
  // MARK: - Helper
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
    case .updateRectAlpha(let alpha):
      // keynoteView.setRectViewAlpha(with: alpha)
      break
    case .updateRectColor(let rgb):
      let color = UIColor(
        red: rgb.R, green: rgb.G, blue: rgb.B, alpha: 1)
      // keynoteView.setRectViewColor(with: color)
      break
    }
  }
}

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
      else { return .init(style: .default, reuseIdentifier: SlideMenuViewCell.id)}
      let item = slideManager.cellItem(at: indexPath.row)
      if let rectModel = item.getinstance as? RectModel {
        let rgb = rectModel.rgb
        cell.configure(
          with: rectModel.alpha,
          color: UIColor(
            red: CGFloat(rgb.R),
            green: CGFloat(rgb.G),
            blue: CGFloat(rgb.B),
            alpha: rectModel.alpha))
      }
      
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
