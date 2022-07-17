//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 17/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CryptoService.shared.getAllIcons()

//        if #available(iOS 15, *) {
//                        let navigationBarAppearance = UINavigationBarAppearance()
//                        navigationBarAppearance.configureWithOpaqueBackground()
//                        navigationBarAppearance.titleTextAttributes = [
//                            NSAttributedString.Key.foregroundColor : UIColor.white
//                        ]
//                        navigationBarAppearance.backgroundColor = UIColor.black
//                        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
//                        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
//                        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
//
//                    let tabBarApperance = UITabBarAppearance()
//                    tabBarApperance.configureWithOpaqueBackground()
//                    tabBarApperance.backgroundColor = UIColor.black
//                    UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
//                    UITabBar.appearance().standardAppearance = tabBarApperance
//                }

        return true
    }
}

