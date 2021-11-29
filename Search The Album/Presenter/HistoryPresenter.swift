//
//  HistoryPresenter.swift
//  Search The Album
//
//  Created by Daria Ten on 29.11.2021.
//

import Foundation

protocol HistoryPresenterProtocol {

	func requestHistory() -> [String]

	func delete(at position: Int)
}

final class HistoryPresenter: HistoryPresenterProtocol {

	private let dataManager: CoreDataManagerProtocol
	private var requests: [RecentAlbum] = []

	init(dataManager: CoreDataManagerProtocol) {
		self.dataManager = dataManager
	}

	func requestHistory() -> [String] {
		let requests = dataManager.get(ofType: RecentAlbum.self)
		self.requests = requests
		return requests.map { $0.title ?? "" }
	}

	func delete(at position: Int) {
		let requestToDelete = requests[position]
		dataManager.delete(entity: requestToDelete)
		dataManager.save()
	}
}
