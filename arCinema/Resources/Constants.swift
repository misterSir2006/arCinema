//
//  Constants.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit

struct Constants {

    // MARK: Content
    struct ReuseIDs {
        static let videosTableViewReuseIdentifier = "videosTableReuseID"
    }

    struct API {
        static let apiKey = "cde0c76f21f85b397060bed7823419bf358bb6b6dc32a3469f05a917d6a9b8cd"
        static let baseURL = "https://serpapi.com/search?engine=yandex_videos"

    }

    struct LocStrings {
        /// VideosViewController Localized Strings
        static let cancel = "cancel".localized
        static let error = "error".localized
        static let invalidUrl = "invalid_url".localized
        static let sourceMode = "source_mode".localized
        static let cinemaMode = "cinema_mode".localized
        static let chooseMode = "choose_mode".localized
        static let barSearch = "bar_search".localized
        static let hint = "hint".localized
        static let feed = "feed".localized
        static let enterQuery = "enter_query".localized
        static let nilViews = "nil_views".localized
        static let nilDate = "nil_date".localized
        static let nilTitle = "nil_title".localized
        static let sample = "sample".localized

        /// CinemaViewController
        static let backToFeed = "back_to_feed".localized
        static let replay = "replay".localized
        static let videoEnded = "video_ended".localized
        static let chooseOption = "choose_option".localized
        static let sessionFailure = "session_failure".localized
        static let cameraCheck = "camera_check".localized

        /// Services
        static let smthWrong = "smth_wrong".localized
        static let checkConnection = "check_connection".localized
    }

    // MARK: - Design
    struct Colors {

    }

    struct Images {
        static let placeholderImage = "https://via.placeholder.com/180/?text=No+Thumbnail+Provided"
        static let play = UIImage(systemName: "play")?.withRenderingMode(.alwaysTemplate)
        static let pause = UIImage(systemName: "pause")?.withRenderingMode(.alwaysTemplate)
        static let soundOn = UIImage(systemName: "speaker.wave.2")?.withRenderingMode(.alwaysTemplate)
        static let soundOff = UIImage(systemName: "speaker.slash")?.withRenderingMode(.alwaysTemplate)
    }
}
