//
//  SourceView.swift
//  arCinema
//
//  Created by Илья Шахназаров on 17.02.2023.
//

import WebKit

final class SourceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var webView = WKWebView()
    lazy var progressView = UIProgressView(progressViewStyle: .default)

    private func fill() {
        backgroundColor = .darkGray
        progressView.sizeToFit()

        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
}
