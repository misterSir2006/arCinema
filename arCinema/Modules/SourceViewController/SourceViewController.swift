//
//  SourceViewController.swift
//  arCinema
//
//  Created by Илья Шахназаров on 17.02.2023.
//

import WebKit

final class SourceViewController: UIViewController, WKNavigationDelegate {

    private let vcView = SourceView()
    private let presenter = SourcePresenter()

    let url: URL

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = vcView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.appearance(bgColor: .darkGray, textColor: .systemBlue)
        navigationController?.setToolbarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setToolbarHidden(true, animated: true)
    }

    // MARK: Funcs
    private func setupUI() {
        toolbarItems = presenter.setupToolbar(webView: vcView.webView,
                                              progressView: vcView.progressView)

        vcView.webView.navigationDelegate = self
        vcView.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        vcView.webView.load(URLRequest(url: url))
        vcView.webView.allowsBackForwardNavigationGestures = true
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {

        if keyPath == "estimatedProgress" {
            vcView.progressView.progress = Float(vcView.webView.estimatedProgress)
        }
    }

}
