//
//  AppDelegate.swift
//  ExplorerGoogle
//
//  Created by Weslley on 02/10/19.
//  Copyright © 2019 URPay. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        GMSPlacesClient.provideAPIKey("AIzaSyBU0SPK0agG9uyGpUwXsc0uEwLe01OVLis")
        
        
                   //setando os frames
                   window = UIWindow(frame: UIScreen.main.bounds)
             
                   let NavController = UINavigationController(rootViewController: ExplorerViewController())
                   
                   
                   window?.rootViewController = NavController
                   window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

