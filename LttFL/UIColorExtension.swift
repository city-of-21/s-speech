//
//  UIColorExtension.swift
//  LttFL
//
//  Created by ken morobayashi on 2015/03/14.
//  Copyright (c) 2015年 ken morobayashi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func getColor (var hexStr : NSString,var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            return UIColor.whiteColor();
        }
    }
    
}
