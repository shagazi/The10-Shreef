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
        nowPlayingNav.navigationBar.isHidden = true

        let upcomingVC = UpcomingVC()
        let upcomingNav = UINavigationController(rootViewController: upcomingVC)
        upcomingNav.navigationBar.isHidden = true

        tab.addChild(nowPlayingNav)
        tab.addChild(upcomingNav)

        return tab
    }()

    static func setWindowRootVC(to viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UIView.transition(with: appDelegate.window!, duration: 3.0, options: .transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = viewController
        }, completion: nil)
    }

}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 60
        return sizeThatFits
    }
}
