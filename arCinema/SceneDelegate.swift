//
//  SceneDelegate.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit
import SnapKit
import Kingfisher

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)

        let rootVc = UINavigationController(rootViewController: VideosViewController())
        self.window?.rootViewController = rootVc

        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
