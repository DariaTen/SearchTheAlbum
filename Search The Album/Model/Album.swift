//
//  Album.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import Foundation

struct Albums: Decodable {
	
	let results : [Album]
}

struct Album: Decodable, Equatable {

	let artistName: String
	let collectionName: String
	let collectionId: Int
	let artworkUrl100: String
	let releaseDate: String
	let primaryGenreName: String
}
