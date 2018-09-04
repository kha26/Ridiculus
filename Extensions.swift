//
//  Extensions.swift
//  Pods-Ridiculus_Example
//
//  Created by Kemal Hasan Atay on 8/4/18.
//

import CoreGraphics

extension CGFloat {
    static func random( _ lower: CGFloat, _ upper: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(100)) / 100 * (upper - lower) + lower
    }
}

