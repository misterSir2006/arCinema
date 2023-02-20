//
//  SourcePresenter.swift
//  arCinema
//
//  Created by Илья Шахназаров on 19.02.2023.
//

import WebKit

class SourcePresenter {

    func setupToolbar(webView: WKWebView, progressView: UIProgressView) -> [UIBarButtonItem]? {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView,
                                      action: #selector(webView.reload))
        let progressButton = UIBarButtonItem(customView: progressView)

        let toolbarItems = [progressButton, spacer, refresh]

        return toolbarItems
    }

}
