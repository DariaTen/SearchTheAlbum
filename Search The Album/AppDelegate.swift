//
//  AppDelegate.swift
//  Search The Album
//
//  Created by Daria Ten on 25.11.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()
		window?.makeKeyAndVisible()
		let assembly = ModulesAssembly(context: persistentContainer.viewContext)
		if let rootViewController = assembly.makeSearchController(),
		   let historyController = assembly.makeHistoryController() {
			let tabBarViewController = assembly.makeTabBar()
			rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
			historyController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
			let searchNVC = UINavigationController(rootViewController: rootViewController)
			let historyNVC = UINavigationController(rootViewController: historyController)
			tabBarViewController.viewControllers = [searchNVC, historyNVC]
			window?.rootViewController = tabBarViewController
		}

		return true
	}

	func applicationWillTerminate(_ application: UIApplication) {
		self.saveContext()
	}

	// MARK: - Core Data Stack

	lazy var persistentContainer: NSPersistentContainer = {

		let container = NSPersistentContainer(name: "DataModel")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
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
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
