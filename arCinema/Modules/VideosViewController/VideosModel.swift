//
//  VideosModel.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import Foundation

class VideosModel {

    // MARK: - Videos
    struct Videos: Codable {
        let videosResults: [VideosResult]

        enum CodingKeys: String, CodingKey {
            case videosResults = "videos_results"
        }
    }

    // MARK: - VideosResult
    struct VideosResult: Codable {
        let position: Int?
        let thumbnail: String?
        let preview: Preview?
        let title, description, views, date: String?
        let original: String?
        let source: String?
        let duration: String?
        let resolution: String?
    }

    // MARK: - Preview
    struct Preview: Codable {
        let url: String?
    }
}
