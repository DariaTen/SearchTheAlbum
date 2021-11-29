//
//  UrlParsler.swift
//  Search The Album
//
//  Created by Daria Ten on 24.11.2021.
//

import Foundation

protocol UrlParserProtocol {
	
	func createUrl(host: String, path: String, query: [String:Any]) -> String
}

final class UrlParser: UrlParserProtocol {
	
	func createUrl(host: String, path: String, query: [String:Any]) -> String {
		guard !host.isEmpty else { return "" }
		var requestQuery = ""
		for (key, value) in query {
			requestQuery = requestQuery + "\(key)=\(value)&"
		}
		if !path.isEmpty && !query.isEmpty {
			requestQuery.removeLast()
		}
		var createdUrl = "\(host)/\(path)?\(requestQuery)"
		if path.isEmpty {
			createdUrl = host
		}
		let url = createdUrl.replacingOccurrences(of: " ", with: "+")
		
		return url
	}
}
