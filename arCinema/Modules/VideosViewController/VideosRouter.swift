//
//  VideosRouter.swift
//  arCinema
//
//  Created by Илья Шахназаров on 20.02.2023.
//

import UIKit

class VideosRouter {

    enum PushToVc {
        case cinema
        case source
    }

    func pushTo(_ topVc: UIViewController? = UIApplication.getTopVC(), url: URL, to push: PushToVc) {
        var vcToPush = UIViewController()

        switch push {
        case .cinema:
            vcToPush = CinemaViewController(videoUrl: url)
        case .source:
            vcToPush = SourceViewController(url: url)
        }

        if let topVc = topVc {
            topVc.navigationController?.pushViewController(vcToPush, animated: true)
        }
    }
}
