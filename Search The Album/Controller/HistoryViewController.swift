//
//  HistoryViewController.swift
//  Search The Album
//
//  Created by Daria Ten on 22.11.2021.
//

import UIKit

final class HistoryViewController: UIViewController {

	static func storyboardInstance() -> HistoryViewController? {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? HistoryViewController
	}

	@IBOutlet weak var tableView: UITableView!

	private var history: [String] = []

	var presenter: HistoryPresenter?
	var router: Router?

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "History"
		navigationController?.navigationBar.prefersLargeTitles = true

		tableView.dataSource = self
		tableView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		loadData()
	}

	// MARK: - Private

	private func loadData() {
		history = presenter?.requestHistory() ?? []
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		history.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
		cell.textLabel?.text = history[indexPath.row]

		return cell
	}
}

// MARK: - UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let recentAlbum = history[indexPath.row]
		router?.showSearchWithRequest(from: self, request: recentAlbum)
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			history.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			presenter?.delete(at: indexPath.row)
		}
	}
}
