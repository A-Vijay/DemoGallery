//
//  AppDelegate.swift
//  DemoGallery
//
//  Created by Vijay A on 10/03/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let vc = GalleryViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        return true
    }


}

