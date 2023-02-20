//
//  String+Extension.swift
//  arCinema
//
//  Created by Илья Шахназаров on 17.02.2023.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
