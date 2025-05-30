//
//  AppDelegate.swift
//  InfiniteCards
//
//  Created by Shalom Sims on 5/29/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create window programmatically
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create tab bar controller
        let tabBarController = UITabBarController()
        
        // Create our view controllers
        let cardsListVC = CardsListViewController()
        let storeVC = UIViewController() // Placeholder
        let summonVC = UIViewController() // Placeholder
        let settingsVC = UIViewController() // Placeholder
        
        // Wrap each in navigation controller
        let cardsNavController = UINavigationController(rootViewController: cardsListVC)
        let storeNavController = UINavigationController(rootViewController: storeVC)
        let summonNavController = UINavigationController(rootViewController: summonVC)
        let settingsNavController = UINavigationController(rootViewController: settingsVC)
        
        // Configure tab bar items
        cardsNavController.tabBarItem = UITabBarItem(
            title: "Cards",
            image: UIImage(systemName: "square.grid.2x2"),
            selectedImage: UIImage(systemName: "square.grid.2x2.fill")
        )
        
        storeNavController.tabBarItem = UITabBarItem(
            title: "Store",
            image: UIImage(systemName: "bag"),
            selectedImage: UIImage(systemName: "bag.fill")
        )
        
        summonNavController.tabBarItem = UITabBarItem(
            title: "Summon",
            image: UIImage(systemName: "arrow.2.squarepath"),
            selectedImage: UIImage(systemName: "arrow.2.squarepath")
        )
        
        settingsNavController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        // Set the view controllers
        tabBarController.viewControllers = [
            cardsNavController,
            storeNavController,
            summonNavController,
            settingsNavController
        ]
        
        // Set tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBarController.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }
        
        // Set as root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

