//
//  Router.swift
//  Search The Album
//
//  Created by Daria Ten on 28.11.2021.
//

import UIKit

final class Router {

	var assembly: ModulesAssembly?

	init(assembly: ModulesAssembly?) {
		self.assembly = assembly
	}

	func showInfoController(from controller: UIViewController,
							for album: Album,
							and image: UIImage) {
		guard
			let infoController = assembly?.makeAlbumInfoController(for: album, and: image)
		else { return }
		controller.navigationController?.pushViewController(infoController, animated: true)
	}

	func showSearchWithRequest(from controller: UIViewController,
							   request: String) {
		guard let tabBar = controller.tabBarController,
			  let navigationController = tabBar.viewControllers?.first as? UINavigationController,
			  let searchController = navigationController.viewControllers.first as? SearchViewController
		else { return }
		tabBar.selectedViewController = navigationController
		searchController.requestAlbum(request)
	}
}
