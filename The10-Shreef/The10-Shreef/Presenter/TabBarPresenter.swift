//
//  TabBarPresenter.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/13/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var tabBarHeight = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.layer.borderWidth = 0.0
        self.tabBar.clipsToBounds = true
        self.tabBar.itemPositioning = .fill
        self.tabBar.itemWidth = 50
        self.tabBar.itemSpacing = 50
        self.tabBar.tintColor = UIColor.active
        self.tabBar.barStyle = .black
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBarHeight = self.tabBar.frame.height - 20

        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 18)!]
        appearance.setTitleTextAttributes(attributes, for: .normal)

        let nowPlaying = MovieVC(title: "In Theaters")
        let nowPlayingNav = UINavigationController(rootViewController: nowPlaying)
        nowPlayingNav.navigationBar.isHidden = true

        let comingSoon = MovieVC(title: "Coming Soon")
        let comingSoonNav = UINavigationController(rootViewController: comingSoon)
        comingSoonNav.navigationBar.isHidden = true

        self.addChild(nowPlayingNav)
        self.addChild(comingSoonNav)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        guard let window = UIApplication.shared.keyWindow else {return}
        tabFrame.size.height = tabBarHeight + window.safeAreaInsets.bottom
        self.tabBar.frame = tabFrame
    }
}

class TabBarPresenter {
    static var mainViewController: UIViewController = {
        let tab = TabBarController()

        return tab
    }()

    static func setWindowRootVC(to viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UIView.transition(with: appDelegate.window!, duration: 1.0, options: .transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = viewController
        }, completion: nil)
    }
}
