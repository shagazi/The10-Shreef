//
//  UIFontExtension.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/17/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

extension UIFont  {
    static func movieDetailFont() -> UIFont {
        let font = UIFont(name: "Arial", size: 14)
        return font ?? UIFont.systemFont(ofSize: 14)
    }
    static func mainItemFont() -> UIFont {
        let font = UIFont(name: "Al Nile", size: 16)
        return font ?? UIFont.systemFont(ofSize: 14)
    }

}

