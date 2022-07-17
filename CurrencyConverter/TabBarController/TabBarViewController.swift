//
//  TabBarViewController.swift
//  CurrencyConverter
//
//  Created by Ahmed App iOS Dev - 1 on 14/07/22.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }


    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }


}

