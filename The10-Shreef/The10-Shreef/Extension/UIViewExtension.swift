//
//  UIViewExtension.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

extension UIView {
    func constrain(subview: UIView) {
        self.topAnchor.constraint(equalTo: subview.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: subview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: subview.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: subview.bottomAnchor).isActive = true
    }
}
