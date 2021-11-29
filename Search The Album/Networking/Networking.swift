//
//  Networking.swift
//  Search The Album
//
//  Created by Daria Ten on 24.11.2021.
//

import Foundation

protocol NetworkingProtocol {
	
	func getAlbum(requestedAlbums: String, completion: @escaping (Albums)-> ())
	
	func getTrack(collectionId: Int, completion: @escaping (Tracks)-> ())
}

final class Networking: NetworkingProtocol {
	
	private enum Constants {
		static let host = "https://itunes.apple.com"
		static let searchEndpoint = "search"
		static let lookupEndpoint = "lookup"
	}
	
	private let urlParser: UrlParserProtocol
	
	init(urlParser: UrlParserProtocol = UrlParser()) {
		self.urlParser = urlParser
	}
	
	func getAlbum(requestedAlbums: String, completion: @escaping (Albums)-> ()) {
		let resultUrl = urlParser.createUrl(host: Constants.host,
											path: Constants.searchEndpoint,
											query: ["entity" : "album",
													"attribute" : "albumTerm",
													"offset" : "0",
													"limit" : "100",
													"term": requestedAlbums])
		
		guard let url = URL(string: resultUrl) else { return }
		performRequest(resultUrl: url, completion: completion)
	}
	
	func getTrack(collectionId: Int, completion: @escaping (Tracks)-> ()) {
		let resultUrl = urlParser.createUrl(host: Constants.host,
											path: Constants.lookupEndpoint,
											query: ["entity": "song",
													"id" : collectionId
												   ])
		
		guard let url = URL(string: resultUrl) else { return }
		performRequest(resultUrl: url, completion: completion)
	}
	
	// MARK: - Private
	
	private func performRequest<DecodedData: Decodable>(resultUrl: URL,
														completion: @escaping (DecodedData) -> ()) {
		let task = URLSession.shared.dataTask(with: resultUrl) { (data, response, error) in
			guard let data = data,
				  error == nil
			else { return }
			do {
				let decodedData = try JSONDecoder().decode(DecodedData.self, from: data)
				completion(decodedData)
			} catch {
				print(error)
			}
		}
		task.resume()
	}
}
