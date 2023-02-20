//
//  SizeButton.swift
//  arCinema
//
//  Created by Илья Шахназаров on 18.02.2023.
//

import UIKit

class SizeButton: UIButton {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Fill
    private func fill() {
        titleLabel?.font = .systemFont(ofSize: 22, weight: .ultraLight)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        layer.cornerRadius = 25
    }

}
