//
//  WelcomeVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/18/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            TabBarPresenter.setWindowRootVC(to: TabBarPresenter.mainViewController)
        }
    }
}
