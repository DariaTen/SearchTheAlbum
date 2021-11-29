//
//  SearchPresenter.swift
//  Search The Album
//
//  Created by Daria Ten on 23.11.2021.
//

import Foundation

protocol SearchPresenterProtocol {

	func searchAlbum(searchedText: String)

	func save(_ albumRequest: String)
}

final class SearchPresenter: SearchPresenterProtocol {

	weak var delegate: SearchView?

	private let networking: NetworkingProtocol
	private let dataManager: CoreDataManagerProtocol

	init(networking: NetworkingProtocol = Networking(),
		 dataManager: CoreDataManagerProtocol) {
		self.networking = networking
		self.dataManager = dataManager
	}

	func searchAlbum(searchedText: String) {
		networking.getAlbum(requestedAlbums: searchedText) { searchedAlbums in
			let sortedAlbums = Albums(
				results: searchedAlbums.results.sorted { $0.collectionName < $1.collectionName}
			)
			DispatchQueue.main.async {
				self.delegate?.updateAlbums(sortedAlbums)
			}
		}
	}

	func save(_ albumRequest: String) {
		let managerObject = dataManager.create(ofType: RecentAlbum.self)
		managerObject.title = albumRequest
		dataManager.save()
	}
}
