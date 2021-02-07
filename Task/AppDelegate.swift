//
//  AppDelegate.swift
//  Task
//
//  Created by Davit Martirosyan on 02.02.21.
//

import UIKit
import CoreData

@main

class AppDelegate: UIResponder, UIApplicationDelegate {

      var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        guard
            let splitViewController = window?.rootViewController as? SplitViewController,
            let leftNavController = splitViewController.viewControllers.first
                as? UINavigationController,
            let masterViewController = leftNavController.viewControllers.first
                as? ViewController
        else { fatalError() }

        if #available(iOS 14.0, *) {
            
            guard let rightNavController = splitViewController.viewControllers.last
                as? UINavigationController
                
            else { fatalError() }
            
            let detailViewController = rightNavController.viewControllers.first
                as? DetailsVC
            
            masterViewController.delegate = detailViewController
            
        } else {
            
            guard let detailViewController = splitViewController.viewControllers.last
                as? DetailsVC
              else { fatalError() }
            
            masterViewController.delegate = detailViewController
        }
        return true

    }


  
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Task")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

