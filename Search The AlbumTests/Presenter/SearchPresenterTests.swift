//
//  SearchPresenterTests.swift
//  Search The AlbumTests
//
//  Created by Daria Ten on 27.11.2021.
//

import XCTest
import CoreData

@testable import Search_The_Album

final class SearchPresenterTests: XCTestCase {

	private var presenter: SearchPresenter!
	private var networking: NetworkingMock!
	private var dataManager: CoreDataManagerProtocolMock!

	override func setUp() {
		super.setUp()
		networking = NetworkingMock()
		dataManager = CoreDataManagerProtocolMock()
		presenter = SearchPresenter(networking: networking, dataManager: dataManager)
	}

	override func tearDown() {
		networking = nil
		dataManager = nil
		presenter = nil
		super.tearDown()
	}

	func testWhenSearchAlbumCalledThanNetworkingCalled() {
		// Arrange
		// Act
		presenter.searchAlbum(searchedText: "")

		// Assert
		XCTAssertEqual(networking.getAlbumCount, 1)
	}
}

final class NetworkingMock: NetworkingProtocol {

	var getAlbumCount = 0
	func getAlbum(requestedAlbums: String, completion: @escaping (Albums) -> ()) {
		getAlbumCount += 1
	}
	var getTrackCount = 0
	func getTrack(collectionId: Int, completion: @escaping (Tracks) -> ()) {
		getTrackCount += 1
	}
}

final class CoreDataManagerProtocolMock: CoreDataManagerProtocol {

	var getCount = 0
	func get<Entity>(ofType: Entity.Type) -> [Entity] where Entity : NSManagedObject {

		getCount += 1

		return []
	}

	var createCount = 0
	func create<Entity>(ofType: Entity.Type) -> Entity where Entity : NSManagedObject {

		createCount += 1

		return RecentAlbum() as! Entity
	}

	var saveCount = 0
	func save() {

		createCount += 1
	}

	var deleteCount = 0
	func delete(entity: NSManagedObject) {

		deleteCount += 1
	}
}
