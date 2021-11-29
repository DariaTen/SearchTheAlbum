//
//  AlbumInfoPresenterTests.swift
//  Search The AlbumTests
//
//  Created by Daria Ten on 27.11.2021.
//

import XCTest
@testable import Search_The_Album

final class AlbumInfoPresenterTests:XCTestCase {

	private var presenter: AlbumInfoPresenter!
	private var networking: NetworkingMock!

	override func setUp() {
		super.setUp()
		networking = NetworkingMock()
		presenter = AlbumInfoPresenter(networking: networking)
	}
	
	override func tearDown() {
		networking = nil
		presenter = nil
		super.tearDown()
	}

	func testWhenSearchTrackCalledThanNetworkingCalled() {
		// Arrange
		// Act
		let album = Album(artistName: "", collectionName: "", collectionId: 0, artworkUrl100: "", releaseDate: "", primaryGenreName: "")
		presenter.loadListOfTracks(for: album)

		// Assert
		XCTAssertEqual(networking.getTrackCount, 1)
	}
}
