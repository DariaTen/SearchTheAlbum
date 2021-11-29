//
//  AlbumCell.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel!

	static let reuseIdentifier = "AlbumCell"
	
    func updateAlbumCell(album: Album) {
        
		guard let albumImageURL = URL(string: album.artworkUrl100) else { return }
        
        DispatchQueue.global().async {
            if let albumImageData = try? Data(contentsOf: albumImageURL) {
                DispatchQueue.main.async {
                    self.albumImageView.image = UIImage(data: albumImageData)
                }
            }
        }
        albumTitleLabel.text = album.collectionName
        artistTitleLabel.text = album.artistName
    }
}
