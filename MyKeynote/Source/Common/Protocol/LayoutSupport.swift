//
//  LayoutSupport.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit


/// UIView's layout support
///
///  Notes:
/// 1. UIView의 레이아웃을 지정할 때 사용되는 프로토콜입니다.
///
///  Examples:
/// ```
/// class ViewController: UIViewController {
///   // MARK: - Properties
///   let emptyView = {
///     let emptyView = UIView()
///     ...
///     return emptyView
///   }()
///   let aView = UIView()
///   let bView = UIView()
///
///   // MARK: - Lifecycle
///   override func viewDidLoad() {
///     super.viewDidLoad()
///     setupSubviewUI(emptyView, aView, bView)
///   }
/// }
///
/// // MARK: - LayoutSupport
/// extension ViewController: LayoutSupport {
///
///  func setConstraints() {
///    //이곳에서 뷰에 대한 constraint지정
///    aView.leadingAnchor.constriant(...).isActive = true
///  }
///}
/// ```
///
protocol LayoutSupport {
  /// Set subviews constraints in root view
  func setConstraints()
}

extension LayoutSupport where Self: UIView {
  // 함수 호출시 superView에 포함될 subviews 포함
  func setupSubviewUI(with subviews: UIView...) {
    addSubviews(subviews)
    setConstraints()
  }
  
  /// Add subviews in root view
  func addSubviews(_ views: UIView...) {
    self.addSubviews(views)
  }
}
extension LayoutSupport where Self: UICollectionViewCell {
  // 함수 호출시 superView에 포함될 subviews 포함
  func setupSubviewUIa(with subviews: UIView...) {
    addSubviewsInContentView(subviews)
    setConstraints()
  }
  func addSubviewsInContentView(_ views: [UIView]) {
    contentView.addSubviews(views)
  }
}

extension LayoutSupport where Self: UITableViewCell {
  func setupSubviewUIb(with subviews: UIView...) {
    addSubviewsInContentView(subviews)
    setConstraints()
  }
  
  func addSubviewsInContentView(_ views: [UIView]) {
    contentView.addSubviews(views)
  }
}
