//
//  ViewCell+Extensions.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

