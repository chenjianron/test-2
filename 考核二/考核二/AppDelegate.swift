//
//  AppDelegate.swift
//  考核二
//
//  Created by GC on 2021/7/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //         建立一個 UIWindow
        self.window = UIWindow(frame:
          UIScreen.main.bounds)

        // 設置底色
        self.window!.backgroundColor = UIColor.white

        // 設置根視圖控制器
        let nav = UINavigationController(
          rootViewController: ViewController())
        self.window!.rootViewController = nav

        // 將 UIWindow 設置為可見的
        self.window!.makeKeyAndVisible()

        return true
    }

    

}

