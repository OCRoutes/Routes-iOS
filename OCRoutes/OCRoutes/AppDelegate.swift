//
//  AppDelegate.swift
//  OCRoutes
//
//  Created by Brandon Danis on 2018-01-30.
//  Copyright © 2018 RoutesInc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootView: UIViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Setting global attributes //
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 18)!
        ]
        UIApplication.shared.statusBarStyle = .lightContent
        
        window?.rootViewController = LoadingScreenViewController()
        window?.makeKeyAndVisible()
        
        // Remove the name of previous view from navigation bar next to back button
//        let BarButtonItemAppearance = UIBarButtonItem.appearance()
//        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        
        UINavigationBar.appearance().tintColor = Style.mainColor
        
        return true
    }
    
    func switchToMainView() {
        // root tab controller init
        let rootTabController = UITabBarController()
        
        // home view init
        let favoriteNavController = UINavigationController()
        favoriteNavController.viewControllers = [HomeViewController()]
        
        // all routes view init
        let routesNavController = UINavigationController()
        routesNavController.viewControllers = [RoutesViewController()]
        
        // all stops view init
        let stopsNavController = UINavigationController()
        stopsNavController.viewControllers = [StopsViewController()]
        
        // map view init
        let mapNavController = UINavigationController()
        let mapVC = MapViewController()
        mapVC.SetupAllBusStops()
        mapNavController.viewControllers = [mapVC]
        
        // Inserting root view controllers into tab controller
        rootTabController.viewControllers = [favoriteNavController, routesNavController, stopsNavController, mapNavController]
        
        // Setting up tab bar icons/titles
        let tabBarItems = rootTabController.tabBar.items! as [UITabBarItem]
        rootTabController.tabBar.tintColor = Style.mainColor
        tabBarItems[0].image = UIImage(named: "star")
        tabBarItems[0].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[1].image = UIImage(named: "front-bus")
        tabBarItems[1].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[2].image = UIImage(named: "direction")
        tabBarItems[2].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[3].image = UIImage(named: "map")
        tabBarItems[3].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        
        self.window?.rootViewController = rootTabController
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

