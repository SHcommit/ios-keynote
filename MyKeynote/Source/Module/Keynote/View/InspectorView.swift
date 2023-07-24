//
//  InspectorView.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/21.
//

import UIKit

final class InspectorView: UIView {
  // MARK: - Constant
  struct Constant {
    enum BackgroundColorLabel {
      static let textSize: CGFloat = 14
      static let spacing: UISpacing = .init(leading:7, top: 7)
      static let edgeInset: UIEdgeInsets = .init(top: 7, left: 7*3, bottom: 7, right: 7*3)
    }
    
    enum BackgroundColorStateView {
      static let textSize: CGFloat = 14
      static let spacing: UISpacing = .init(leading:7, top: 7)
      static let bgColor: UIColor = .systemYellow.withAlphaComponent(0.7)
    }
    
    enum AlphaLabel {
      static let textSize: CGFloat = 14
    }
    
    enum AlphaView {
      static let spacing: UISpacing = .init(leading:7, top: 7*2, trailing: 7)
    }
  }
  
  // MARK: - UI Properties
  private let backgroundColorLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "배경색"
    $0.font = .systemFont(
      ofSize: Constant.BackgroundColorLabel.textSize,
      weight: .semibold)
  }
  
  private let backgroundColorStateView = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: Constant.BackgroundColorStateView.textSize)
    $0.backgroundColor = Constant.BackgroundColorStateView.bgColor
    $0.textAlignment = .center
  }
  
  private let alphaLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = "투명도"
    $0.font = .systemFont(
      ofSize: Constant.AlphaLabel.textSize,
      weight: .semibold)
  }
  
  private let alphaView = AlphaView()
  
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray6 
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}
