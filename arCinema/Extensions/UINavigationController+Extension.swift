//
//  UINavigationController+Extension.swift
//  arCinema
//
//  Created by Илья Шахназаров on 17.02.2023.
//

import UIKit

extension UINavigationController {

    func appearance(bgColor: UIColor, textColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = bgColor
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: textColor]

        self.navigationBar.tintColor = .orange
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }

}
