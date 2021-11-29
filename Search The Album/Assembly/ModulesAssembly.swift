//
//  ModulesAssembly.swift
//  Search The Album
//
//  Created by Daria Ten on 28.11.2021.
//

import Foundation
import CoreData
import UIKit

final class ModulesAssembly {

	private let context: NSManagedObjectContext

	private lazy var networking = Networking()
	private lazy var dataManager = CoreDataManager(context: context)
	private lazy var router = Router(assembly: self)

	init(context: NSManagedObjectContext) {
		self.context = context
	}

	func makeTabBar() -> UITabBarController {
		let tabBar = UITabBarController()
		tabBar.tabBar.tintColor = .systemPink

		return tabBar
	}

	func makeSearchController() -> SearchViewController? {
		let controller = SearchViewController.storyboardInstance()
		let presenter = SearchPresenter(networking: networking,
										dataManager: dataManager)
		controller?.searchPresenter = presenter
		controller?.router = router
		presenter.delegate = controller
		return controller
	}

	func makeAlbumInfoController(for album: Album, and image: UIImage) -> AlbumInfoViewController? {
		let controller = AlbumInfoViewController.storyboardInstance()
		controller?.album = album
		controller?.image = image
		let presenter = AlbumInfoPresenter(networking: networking)
		controller?.albumInfoPresenter = presenter
		presenter.delegate = controller
		return controller
	}

	func makeHistoryController() -> HistoryViewController? {
		let controller = HistoryViewController.storyboardInstance()
		let presenter = HistoryPresenter(dataManager: dataManager)
		controller?.presenter = presenter
		controller?.router = router
		return controller
	}
}
