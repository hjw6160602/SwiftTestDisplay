//
//  Const.swift
//  测试界面Swift
//
//  Created by SaiDiCaprio on 2021/3/16.
//

import UIKit

let kScreenFrame  = UIScreen.main.bounds
let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth  = UIScreen.main.bounds.width
let kStatusBarH   = UIApplication.shared.statusBarFrame.height

let k_iPhoneX_Series = (kScreenWidth >= 375) && (kScreenHeight >= 812)

let kCustomNaviBarH = CGFloat(44)
let kNavigationBarH = kStatusBarH + kCustomNaviBarH
let kBottomMargin: CGFloat = k_iPhoneX_Series ? 34 : 0
let kBottomInputMargin: CGFloat = k_iPhoneX_Series ? 34 : 10
let kTabBarH = kBottomMargin + 49
