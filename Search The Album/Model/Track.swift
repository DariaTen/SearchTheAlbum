//
//  Track.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import Foundation

struct Tracks: Decodable {
	
	let results : [Track]
}

struct Track: Decodable {
	
	var trackName: String?
	var trackNumber: Int?
}
