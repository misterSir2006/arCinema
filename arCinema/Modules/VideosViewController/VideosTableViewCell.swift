//
//  VideosTableViewCell.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit
import Kingfisher

class VideosTableViewCell: UITableViewCell {

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(data: [VideosModel.VideosResult], indexPath: IndexPath) {

        let thumbnail = URL(string: data[indexPath.row].thumbnail ?? Constants.Images.placeholderImage)
        self.thumbnailImageView.kf.setImage(with: thumbnail)

        self.viewsLabel.text = data[indexPath.row].views ?? Constants.LocStrings.nilViews
        self.dateLabel.text = data[indexPath.row].date ?? Constants.LocStrings.nilDate

        self.titleLabel.text = data[indexPath.row].title ?? Constants.LocStrings.nilTitle
    }

    // MARK: Properties
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.sizeToFit()

        return label
    }()

    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .right

        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .right

        return label
    }()

    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .light)

        return label
    }()

    // MARK: Fill
    private func fill() {
        selectionStyle = .none
        backgroundColor = .white

        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(100)
        }

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView)
            make.left.equalTo(thumbnailImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }

        addSubview(sourceLabel)
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
        }

        addSubview(viewsLabel)
        viewsLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(5)
        }

        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(viewsLabel.snp.top).offset(-2)
            make.right.equalTo(viewsLabel)
        }
    }
}
