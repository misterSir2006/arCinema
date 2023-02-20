//
//  CinemaPresenter.swift
//  arCinema
//
//  Created by Илья Шахназаров on 17.02.2023.
//

import UIKit
import SceneKit
import ARKit

class CinemaPresenter {

    func setupCinema(player: AVPlayer, arScene: ARSCNView, node: SCNNode) {
        arScene.scene.rootNode.addChildNode(node)
        player.play()
    }

    func videoEndedAlert(player: AVPlayer) {
        let goBackAction = UIAlertAction(title: Constants.LocStrings.backToFeed, style: .default) { _ in
            UIApplication.getTopVC()?.navigationController?.popViewController(animated: true)
        }

        let replayAction = UIAlertAction(title: Constants.LocStrings.replay, style: .default) { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }

        AlertService.showAlert(style: .alert,
                               title: Constants.LocStrings.videoEnded,
                               message: Constants.LocStrings.chooseOption,
                               actions: [goBackAction, replayAction])
    }

    // MARK: PlayerOperations
    enum SizeOperation {
        case increase
        case decrease
    }

    func sizeOperation(_ operation: SizeOperation, plane: SCNPlane) {
        var factor: CGFloat = 0.0

        switch operation {
        case .increase:
            factor = 1.1
        case .decrease:
            factor = 0.9
        }

        plane.height *= factor
        plane.width *= factor
    }

    func pauseOperation(sender: PauseButton, player: AVPlayer) {
        if sender.paused {
            player.pause()
        } else {
            player.play()
        }
    }

    func muteOperation(sender: MuteButton, player: AVPlayer) {
        player.volume = sender.muted ? 0 : 1
    }
}
