//
//  VideosView.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit

final class VideosView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.LocStrings.barSearch,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        bar.barTintColor = .black
        bar.barStyle = .black
        bar.searchTextField.leftView?.tintColor = .orange

        return bar
    }()

    lazy var videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.indicatorStyle = .black
        tableView.separatorColor = .black
        tableView.allowsSelection = true

        return tableView
    }()

    lazy var hintLabel: UILabel = {
        let label = UILabel()

        let hintString = Constants.LocStrings.hint
        let searchString = "`search`"
        let range = (hintString as NSString).range(of: searchString)

        /// Default Attributes
        label.text = hintString
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()

        /// Color changes
        let attributedText = NSMutableAttributedString.init(string: hintString)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: UIColor.orange, range: range)
        label.attributedText = attributedText

        return label
    }()

    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.isHidden = true
        loader.style = .large
        loader.color = .black

        return loader
    }()

    private func fill() {
        backgroundColor = .white

        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }

        addSubview(videosTableView)
        videosTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }

        addSubview(loader)
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
