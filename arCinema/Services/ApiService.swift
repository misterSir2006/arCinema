//
//  ApiService.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit

final class ApiService {

    enum NetworkMethods: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }

    static func post<T: Codable>(for: T.Type = T.self,
                                 url: String, method: NetworkMethods,
                                 completionHandler: @escaping (Result<T, ApiError>) -> Void) {
        guard let requestUrl = URL(string: url) else {
            AlertService.showAlert(style: .alert, title: Constants.LocStrings.invalidUrl, message: nil)
            return
        }
        var request = URLRequest(url: requestUrl)

        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard data != nil else {
                completionHandler(.failure(.httpError))
                return
            }

            if let decodedData = try? JSONDecoder().decode(T.self, from: data!) {
                DispatchQueue.main.async {
                    completionHandler(.success(decodedData))
                }
            } else {
                let error = try? JSONDecoder().decode(ErrorObject.self, from: data!)
                guard let error = error else { return }
                completionHandler(.failure(.serviceError(error)))
            }
        }.resume()
    }

    // MARK: Error object
    struct ErrorObject: Codable {
        var error: String
    }

    enum ApiError: Error {
        case serviceError(ErrorObject)
        case httpError
    }
}
