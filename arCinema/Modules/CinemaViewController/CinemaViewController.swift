//
//  CinemaViewController.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit
import SceneKit
import ARKit

final class CinemaViewController: UIViewController {

    private let vcView = CinemaView()
    private let presenter = CinemaPresenter()

    var videoUrl: URL

    init(videoUrl: URL) {
        self.videoUrl = videoUrl
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNotifications()
        navigationController?.appearance(bgColor: .clear, textColor: .systemBlue)
        presenter.setupCinema(player: vcView.player, arScene: vcView.arSceneView, node: vcView.cinemaNode)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeNotifications()
        vcView.arSceneView.session.pause()
    }

    // MARK: Funcs
    private func setupUI() {
        vcView.arSceneView.session.run(ARWorldTrackingConfiguration(),
                                       options: [.removeExistingAnchors, .resetTracking])
        vcView.arSceneView.delegate = self

        vcView.player = AVPlayer(url: videoUrl)

        vcView.plusButton.addTarget(self, action: #selector(plus), for: .touchUpInside)
        vcView.minusButton.addTarget(self, action: #selector(minus), for: .touchUpInside)
        vcView.pauseButton.addTarget(self, action: #selector(pause(_:)), for: .touchUpInside)
        vcView.muteButton.addTarget(self, action: #selector(mute(_:)), for: .touchUpInside)
    }

    func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didFinishPlaying(_:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: vcView.player.currentItem)
    }

    func removeNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                  object: vcView.player.currentItem)
    }

    @objc func plus() {
        presenter.sizeOperation(.increase, plane: vcView.plane)
    }

    @objc func minus() {
        presenter.sizeOperation(.decrease, plane: vcView.plane)
    }

    @objc func pause(_ sender: PauseButton) {
        presenter.pauseOperation(sender: sender, player: vcView.player)
    }

    @objc func mute(_ sender: MuteButton) {
        presenter.muteOperation(sender: sender, player: vcView.player)
    }

    @objc func didFinishPlaying(_ note: NSNotification) {
        presenter.videoEndedAlert(player: vcView.player)
    }
}

extension CinemaViewController: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        AlertService.showAlert(style: .alert,
                               title: Constants.LocStrings.sessionFailure,
                               message: Constants.LocStrings.cameraCheck)
    }

    func sessionWasInterrupted(_ session: ARSession) {
        vcView.player.pause()
        vcView.pauseButton.paused = true
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        vcView.arSceneView.session.run(ARWorldTrackingConfiguration(),
                              options: [.resetTracking, .removeExistingAnchors])
    }
}
