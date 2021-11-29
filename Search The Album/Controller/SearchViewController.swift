//
//  SearchViewController.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import UIKit

protocol SearchView: AnyObject {
	func updateAlbums(_ albums: Albums)
}

final class SearchViewController: UIViewController {

	static func storyboardInstance() -> SearchViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? SearchViewController
	}

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var collectionView: UICollectionView!

	var searchPresenter: SearchPresenter?
	var router: Router?

	private var albums = [Album]()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Search"

		searchBar.delegate = self
		collectionView.delegate = self
		collectionView.dataSource = self
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	func requestAlbum(_ name: String) {
		searchBar.text = name
		searchPresenter?.searchAlbum(searchedText: name)
	}
}

// MARK: - SearchView

extension SearchViewController: SearchView {

	func updateAlbums(_ albums: Albums) {
		self.albums = albums.results
		collectionView.reloadData()
	}
}

// MARK: - UICollectionViewDataSourse

extension SearchViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return albums.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as? AlbumCell {
			cell.updateAlbumCell(album: albums[indexPath.row])
			return cell
		}
		return UICollectionViewCell()
	}
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let album = albums[indexPath.row]
		if
			let image = (collectionView.cellForItem(at: indexPath) as? AlbumCell)?.albumImageView.image {
			router?.showInfoController(from: self, for: album, and: image)
		}
		searchBar.resignFirstResponder()
	}
}

// MARK: - UISearchBar Methods

extension SearchViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if let text = searchBar.text,
		   !text.trimmingCharacters(in: .whitespaces).isEmpty {
			searchPresenter?.searchAlbum(searchedText: searchBar.text!)

			searchPresenter?.save(text)

			searchBar.resignFirstResponder()
		}
	}
}
