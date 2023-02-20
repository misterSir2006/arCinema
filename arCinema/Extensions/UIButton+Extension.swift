//
//  UIButton+Extension.swift
//  arCinema
//
//  Created by Илья Шахназаров on 18.02.2023.
//

import UIKit

extension UIButton {

    func setImageWithFrame(image: UIImage?, inFrame frame: CGRect?, forState state: UIControl.State) {
        self.setImage(image, for: state)

        if let frame = frame {
            self.imageEdgeInsets = UIEdgeInsets(
                top: frame.minY - self.frame.minY,
                left: frame.minX - self.frame.minX,
                bottom: self.frame.maxY - frame.maxY,
                right: self.frame.maxX - frame.maxX
            )
        }
    }

}
