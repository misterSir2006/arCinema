//
//  AlertService.swift
//  arCinema
//
//  Created by Илья Шахназаров on 16.02.2023.
//

import UIKit

final class AlertService {

    // MARK: UIAlertController
    static func showAlert(style: UIAlertController.Style,
                          title: String?,
                          message: String?,
                          actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .cancel, handler: nil)],
                          completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.view.tintColor = .orange

        for action in actions {
            alert.addAction(action)
        }

        if let topVC = UIApplication.getTopVC() {
            alert.popoverPresentationController?.sourceView = topVC.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: topVC.view.bounds.midX,
                                                                     y: topVC.view.bounds.midY,
                                                                     width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
            topVC.present(alert, animated: true, completion: completion)
        }
    }

    static func noConnectionAlert() {
        self.showAlert(style: .alert,
                       title: Constants.LocStrings.smthWrong,
                       message: Constants.LocStrings.checkConnection)
    }
}
