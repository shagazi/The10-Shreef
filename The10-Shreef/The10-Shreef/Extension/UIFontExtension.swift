//
//  UIFontExtension.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/17/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

extension UIFont  {

    static func mainItemFont() -> UIFont {
        let font = UIFont(name: "Al Nile", size: 16)
        return font ?? UIFont.systemFont(ofSize: 14)
    }

}

