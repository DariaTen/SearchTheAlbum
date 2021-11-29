//
//  AlbumInfoViewController.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import UIKit

protocol AlbumInfoView: AnyObject {
	func updateTracks(_ tracks: Tracks)
}

final class AlbumInfoViewController: UIViewController {
	
	static func storyboardInstance() -> AlbumInfoViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? AlbumInfoViewController
	}
	
	@IBOutlet weak var albumImageView: UIImageView!
	@IBOutlet weak var albumLable: UILabel!
	@IBOutlet weak var artistLabel: UILabel!
	@IBOutlet weak var genreLable: UILabel!
	@IBOutlet weak var yearLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	var album: Album?
	var image: UIImage?
	
	var albumInfoPresenter: AlbumInfoPresenter?
	
	private var listOfTracks = [Track]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		tableView.allowsSelection = false
		
		updateAlbumLabels()
		guard let album = album else { return }
		albumInfoPresenter?.loadListOfTracks(for: album)
	}
	
	// MARK: - Update Labels
	
	func updateAlbumLabels() {
		guard let album = album else {return}
		
		albumImageView.image = image
		albumLable.text = album.collectionName
		artistLabel.text = album.artistName
		genreLable.text = album.primaryGenreName.uppercased()
		yearLabel.text = String(album.releaseDate.prefix(4))
	}
}

// MARK: - AlbumInfoView

extension AlbumInfoViewController: AlbumInfoView {
	
	func updateTracks(_ tracks: Tracks) {
		listOfTracks = tracks.results
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSourse

extension AlbumInfoViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listOfTracks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseIdentifier, for: indexPath) as? TrackCell {
			cell.updateTrackCell(track: listOfTracks[indexPath.row])
			return cell
		}
		return UITableViewCell()
	}
}
