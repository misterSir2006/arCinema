//
//  PauseButton.swift
//  arCinema
//
//  Created by Илья Шахназаров on 18.02.2023.
//

import UIKit

class PauseButton: UIButton {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var paused: Bool = false {
        didSet {
            if paused {
                pauseImageView.image = Constants.Images.play
                pauseImageView.tintColor = .orange
                self.layer.borderColor = UIColor.orange.cgColor
            } else {
                pauseImageView.image = Constants.Images.pause
                pauseImageView.tintColor = .white
                self.layer.borderColor = UIColor.white.cgColor
            }
        }
    }

    // MARK: Properties
    private lazy var pauseImageView = UIImageView()

    // MARK: Functions
    @objc func pauseTapped(_ sender: UIButton) {
        if sender == self {
            if paused == false {
                paused = true
            } else {
                paused = false
            }
        }
    }

    private func fill() {
        addTarget(self, action: #selector(pauseTapped(_:)), for: .touchUpInside)
        pauseImageView.image = Constants.Images.pause
        pauseImageView.tintColor = .white

        backgroundColor = .black
        layer.cornerRadius = 40
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor

        addSubview(pauseImageView)
        pauseImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
}
