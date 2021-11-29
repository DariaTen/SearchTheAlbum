//
//  TrackCell.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import UIKit

final class TrackCell: UITableViewCell {

	@IBOutlet weak var trackTitle: UILabel!
	@IBOutlet weak var trackNumber: UILabel!

	static let reuseIdentifier = "TrackCell"

	func updateTrackCell(track: Track) {
		guard let trackNumber = track.trackNumber,
			  let trackName = track.trackName
		else { return }

		self.trackNumber.text = String(trackNumber)
		trackTitle.text = trackName
	}
}
