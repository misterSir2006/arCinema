//
//  CinemaView.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit
import SceneKit
import ARKit

final class CinemaView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var arSceneView: ARSCNView = {
        let scene = ARSCNView()
        scene.showsStatistics = false

        return scene
    }()

    lazy var player = AVPlayer()

    lazy var plane: SCNPlane = {
        let plane = SCNPlane(width: 1.6, height: 0.9)
        plane.firstMaterial?.diffuse.contents = player
        plane.firstMaterial?.isDoubleSided = true

        return plane
    }()

    lazy var cinemaNode: SCNNode = {
        let node = SCNNode(geometry: plane)
        node.position.z = -4
        node.position.y = 0
        node.position.x = 0

        return node
    }()

    lazy var plusButton: SizeButton = {
        let button = SizeButton()
        button.setTitle("+ size", for: .normal)
        button.backgroundColor = .orange

        return button
    }()

    lazy var minusButton: SizeButton = {
        let button = SizeButton()
        button.setTitle("- size", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.orange, for: .normal)

        return button
    }()

    lazy var pauseButton = PauseButton()
    lazy var muteButton = MuteButton()

    private func fill() {

        addSubview(arSceneView)
        arSceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        arSceneView.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.width.equalTo(90)
        }

        arSceneView.addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.bottom.width.height.equalTo(plusButton)
            make.left.equalToSuperview().offset(30)
        }

        arSceneView.addSubview(pauseButton)
        pauseButton.snp.makeConstraints { make in
            make.bottom.equalTo(minusButton)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        arSceneView.addSubview(muteButton)
        muteButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.right.equalToSuperview().offset(-30)
            make.width.height.equalTo(50)
        }
    }
}
