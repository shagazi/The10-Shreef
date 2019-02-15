//
//  TabBarPresenter.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/13/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

class TabBarPresenter {
    static var mainViewController: UIViewController = {
        let tab = UITabBarController()
        tab.tabBar.isTranslucent = false
        tab.tabBar.layer.borderWidth = 0.0
        tab.tabBar.clipsToBounds = true
        tab.tabBar.itemPositioning = .fill
        tab.tabBar.itemWidth = 50
        tab.tabBar.itemSpacing = 50
        tab.tabBar.tintColor = UIColor.active
        tab.tabBar.barStyle = .black
        tab.tabBar.unselectedItemTintColor = UIColor.lightGray

        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 18)!]
        appearance.setTitleTextAttributes(attributes, for: .normal)

        let nowPlayingVC = NowPlayingVC()
        let nowPlayingNav = UINavigationController(rootViewController: nowPlayingVC)
//        nowPlayingNav.isNavigationBarHidden = true
        nowPlayingNav.navigationBar.isHidden = true

        let upcomingVC = UpcomingVC()
        let upcomingNav = UINavigationController(rootViewController: upcomingVC)
//        upcomingNav.isNavigationBarHidden = true
        upcomingNav.navigationBar.isHidden = true


//        tab.selectedIndex = 0

        tab.addChild(nowPlayingNav)
        tab.addChild(upcomingNav)

        return tab
    }()
}

extension UIColor {

    static var active: UIColor {
        return UIColor(red: 0.986, green: 0.079, blue: 0.000, alpha: 1)
    }

}
