//
//  UrlBuilder.swift
//  arCinema
//
//  Created by Илья Шахназаров on 20.02.2023.
//

import UIKit

class UrlBuilder {

    func buildVideosUrl(query: String, on page: Int) -> String {
        let baseUrl = Constants.API.baseURL
        let apiKey = Constants.API.apiKey

        let url = "\(baseUrl)&text=\(query)&api_key=\(apiKey)&p=\(page)"

        return url
    }
}
