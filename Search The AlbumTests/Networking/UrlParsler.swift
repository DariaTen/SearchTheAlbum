//
//  UrlParsler.swift
//  Search The AlbumTests
//
//  Created by Daria Ten on 19.10.2021.
//

import XCTest
@testable import Search_The_Album

final class UrlParslerTests: XCTestCase {
	private var urlParser : UrlParser!

	override func setUp() {
		super.setUp()
		urlParser = UrlParser()
	}

	override func tearDown() {
		urlParser = nil
		super.tearDown()
	}

	func testGivenEmptyQueryAndPathWhenCreateUrlThanGetHost() {
		// Arrange
		let host = "https://itunes.apple.com"

		// Act
		let result = urlParser.createUrl(host: host, path: "", query: [:])

		// Assert
		XCTAssertEqual(host, result)
	}

	func testGivenEmptyHostWhenCreatedUrlThanGetEmptyString() {

		// Arrange
		let path = "search"
		let query = ["entity" : "album",
					 "attribute" : "albumTerm",
					 "offset" : "0",
					 "limit" : "100",
					 "term": "the"]
		let expected = ""

		// Act
		let result = urlParser.createUrl(host: "", path: path, query: query)

		// Assert
		XCTAssertEqual(expected, result)
	}

	func testGivenEmptyPathWhenCreatedUrlThatGetHost() {

		// Arrange
		let host = "https://itunes.apple.com"
		let query = ["entity" : "album",
					 "attribute" : "albumTerm",
					 "offset" : "0",
					 "limit" : "100",
					 "term": "the"]

		// Act
		let result = urlParser.createUrl(host: host, path: "", query: query)

		// Assert
		XCTAssertEqual(host, result)
	}

	func testGivenEmptyQueryWhenCreatedUrlThanGetHostAndPath() {

		// Arrange
		let host = "https://itunes.apple.com"
		let path = "search"
		let expected = "\(host)/\(path)?"

		// Act
		let results = urlParser.createUrl(host: host, path: path, query: [:])

		// Assert
		XCTAssertEqual(expected, results)
	}

	func testGivenAllArgumentsWhenCreatedUrlThanGetUrl() {

		// Arrange
		let host = "https://itunes.apple.com"
		let path = "search"
		let query = ["entity" : "album",
					 "attribute" : "albumTerm",
					 "offset" : "0",
					 "limit" : "100",
					 "term": "the"]

		var requestQuery = ""
		for (key, value) in query {
			requestQuery = requestQuery + "\(key)=\(value)&"
		}
		requestQuery.removeLast()
		
		let expected = "\(host)/\(path)?\(requestQuery)"
		let arrayHostExpected  = expected.split(separator: "/")
		let arrayPathExpected = arrayHostExpected[2].split(separator: "?")
		let arrayQueryExpected = arrayPathExpected[1].split(separator: "&")
		let sortedArrayQueryExpected = arrayQueryExpected.sorted()

		// Act
		let result = urlParser.createUrl(host: host, path: path, query: query)
		let arrayHostResult = result.split(separator: "/")
		let arrayPathResult = arrayHostResult[2].split(separator: "?")
		let arrayQueryResult = arrayPathResult[1].split(separator: "&")
		let sortedArrayQueryResult = arrayQueryResult.sorted()

		// Assert

		XCTAssertEqual(sortedArrayQueryExpected, sortedArrayQueryResult)
	}
}
