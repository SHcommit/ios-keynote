//
//  SceneDelegate.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let rectModelFactory = RectModelFactory()
    let sm = SlideManager(rectModelFactory: rectModelFactory)
    let model1 = sm.makeRectModel()
    let model2 = sm.makeRectModel()
    let slideModel1 = SlideModel(state: .rect(model1))
    let slideModel2 = SlideModel(state: .rect(model2))
    sm.add(slideModel1)
    sm.add(slideModel2)
    window?.rootViewController = KeynoteViewController(slideManager: sm)
    window?.makeKeyAndVisible()
  }
}
