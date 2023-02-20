//
//  VideosPresenter.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit

final class VideosPresenter {

    private let router = VideosRouter()
    private let urlBuilder = UrlBuilder()

    // MARK: UI
    func cellChosen(indexPath: IndexPath, data: [VideosModel.VideosResult]) {
        guard let sourceUrl = data[indexPath.row].original,
              let cinemaUrl = data[indexPath.row].preview?.url else {
            AlertService.showAlert(style: .alert, title: Constants.LocStrings.invalidUrl, message: nil)
            return
        }

        let sourceAction = UIAlertAction(title: Constants.LocStrings.sourceMode, style: .default) { _ in
            guard let url = URL(string: sourceUrl) else { return }
            self.router.pushTo(url: url, to: .source)
        }

        let cinemaAction = UIAlertAction(title: Constants.LocStrings.cinemaMode, style: .default) { _ in
            guard let url = URL(string: cinemaUrl) else { return }
            self.router.pushTo(url: url, to: .cinema)
        }

        let cancel = UIAlertAction(title: Constants.LocStrings.cancel, style: .cancel)

        AlertService.showAlert(style: .actionSheet,
                               title: Constants.LocStrings.chooseMode,
                               message: nil,
                               actions: [sourceAction, cinemaAction, cancel])
    }

    func sampleVideo() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "iphoneX", ofType: "mp4") ?? "")
        router.pushTo(url: url, to: .cinema)
    }

    // MARK: API
    var videos = [VideosModel.VideosResult]()
    var page: Int = 1

    func getVideos(query: String, tableView: UITableView, page: Int, loader: UIActivityIndicatorView) {
        let url = self.urlBuilder.buildVideosUrl(query: query, on: page)
        let tablePass = page == 1 && tableView.numberOfSections > 0

        if tablePass {
            loader.isHidden = false
            loader.startAnimating()
        }

        let group = DispatchGroup()
        group.enter()

        ApiService.post(for: VideosModel.Videos.self, url: url, method: .get) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.videos += data.videosResults
                    tableView.reloadData()
                }

            case .failure(let fail):
                switch fail {
                case .httpError:
                    DispatchQueue.main.async {
                        AlertService.noConnectionAlert()
                    }
                case .serviceError(let error):
                    DispatchQueue.main.async {
                        AlertService.showAlert(style: .alert, title: Constants.LocStrings.error, message: error.error)
                    }
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if tablePass {
                loader.isHidden = true
                loader.stopAnimating()
            }
        }
    }
}
