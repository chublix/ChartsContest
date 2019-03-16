//
//  AppDelegate.swift
//  TeChartsProject
//
//  Created by Andrey Chuprina on 3/10/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let str = "[\"x\", 1, 2, 3, 4, 5, 6, 7, 8, 9]"
        let data = str.data(using: .utf8)!
        if let decoded = try? JSONDecoder().decode([Value].self, from: data) {
            debugPrint(decoded.first?.string ?? "not found")
            let arr = decoded.compactMap { $0.int }
            debugPrint(arr)
        }
        
        return true
    }

}

