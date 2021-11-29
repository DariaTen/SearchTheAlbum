//
//  AlbumInfoPresenter.swift
//  Search The Album
//
//  Created by Daria Ten on 23.11.2021.
//

import Foundation

protocol AlbumInfoPresenterProtocol {

	func loadListOfTracks(for album: Album)
}

final class AlbumInfoPresenter: AlbumInfoPresenterProtocol {
	
	weak var delegate: AlbumInfoView?
	private var album: Album?
	
	private let networking: NetworkingProtocol
	
	init(networking: NetworkingProtocol = Networking()) {
		self.networking = networking
	}

	func loadListOfTracks(for album: Album) {
		networking.getTrack(collectionId: album.collectionId) { tracks in
			let searchedTracks = Tracks(results: tracks.results)
			DispatchQueue.main.async {
				self.delegate?.updateTracks(searchedTracks)
			}
		}
	}
}
