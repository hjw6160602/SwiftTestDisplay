//
//  UIColor+Extension.swift
//  ProjectH-iOS
//
//  Created by HongYu on 2020/12/7.
//

import Foundation
import UIKit


extension UIColor{
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    //返回随机颜色
    class var random:  UIColor  {
        get  {
            let  red =  CGFloat (arc4random() % 256) / 255.0
            let  green =  CGFloat (arc4random() % 256) / 255.0
            let  blue =  CGFloat (arc4random() % 256) / 255.0
            return  UIColor (red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    class func rgb(_ R:Int, _ G:Int, _ B:Int) -> UIColor{
        let red   :CGFloat = CGFloat(R)/255.0
        let green :CGFloat = CGFloat(G)/255.0
        let blue  :CGFloat = CGFloat(B)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class func gray (_ Value:Int) -> UIColor {
        return rgb(Value, Value, Value)
    }
    
    class func rgb(from hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat(hex & 0x0000FF) / 0xFF
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static var title: UIColor = {
        return rgb(23, 23, 25)
    }()

}
