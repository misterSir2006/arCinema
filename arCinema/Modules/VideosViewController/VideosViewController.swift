//
//  VideosViewController.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit

fileprivate let reuseIdentifier = Constants.ReuseIDs.videosTableViewReuseIdentifier

final class VideosViewController: UIViewController {

    private let vcView = VideosView()
    private let presenter = VideosPresenter()

    private var query: String = ""

    override func loadView() {
        view = vcView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardGesture()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.appearance(bgColor: .white, textColor: .black)

        let sample = UIBarButtonItem(title: Constants.LocStrings.sample, style: .plain,
                                     target: self, action: #selector(sampleButtonTapped))
        sample.tintColor = .orange
        navigationItem.rightBarButtonItem = sample
    }

    // MARK: Funcs
    private func setupUI() {
        title = Constants.LocStrings.feed

        vcView.videosTableView.delegate = self
        vcView.videosTableView.dataSource = self
        vcView.videosTableView.register(VideosTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        vcView.searchBar.delegate = self
    }

    @objc func sampleButtonTapped() {
        presenter.sampleVideo()
    }
}

// MARK: TableViewDataSource & Delegate
extension VideosViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                       for: indexPath) as? VideosTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(data: presenter.videos, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = presenter.videos.count - 1
        if indexPath.item == lastElement {
            presenter.page += 1
            presenter.getVideos(query: query,
                                tableView: vcView.videosTableView,
                                page: presenter.page,
                                loader: vcView.loader)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellChosen(indexPath: indexPath, data: presenter.videos)
    }
}

// MARK: SearchBarDelegate
extension VideosViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces),
                  !text.isEmpty else {
            AlertService.showAlert(style: .alert,
                                   title: Constants.LocStrings.sample,
                                   message: Constants.LocStrings.enterQuery)
            return
        }

        query = text.filter { !$0.isWhitespace }
        presenter.page = 1

        presenter.videos.removeAll()
        vcView.hintLabel.isHidden = true

        presenter.getVideos(query: query,
                            tableView: vcView.videosTableView,
                            page: presenter.page,
                            loader: vcView.loader)

        view.endEditing(true)
    }
}
