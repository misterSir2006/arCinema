//
//  MuteButton.swift
//  arCinema
//
//  Created by Илья Шахназаров on 18.02.2023.
//

import UIKit

class MuteButton: UIButton {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var muted: Bool = false {
        didSet {
            muteImageView.image = muted ? Constants.Images.soundOff : Constants.Images.soundOn
        }
    }

    // MARK: Properties
    private lazy var muteImageView = UIImageView()

    // MARK: Functions
    @objc func pauseTapped(_ sender: UIButton) {
        if sender == self {
            if muted == false {
                muted = true
            } else {
                muted = false
            }
        }
    }

    private func fill() {
        addTarget(self, action: #selector(pauseTapped(_:)), for: .touchUpInside)
        muteImageView.image = Constants.Images.soundOn
        muteImageView.tintColor = .white

        backgroundColor = .orange
        layer.cornerRadius = 25

        addSubview(muteImageView)
        muteImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
