//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 17/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        window?.overrideUserInterfaceStyle = .dark
    }
}
