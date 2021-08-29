//
//  CustomNavbar.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import UIKit

enum NavbarType {
    case mainNavbar
    case backNavbar
}

class CustomNavbar: UIView {
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewTitle: UIView!

    var onClickBackButton: (() -> Void)?

    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingCompressedSize
    }

    func setNavbarType(type: NavbarType) {
        // if type equals to main navbar, then hide back button
        viewBack.isHidden = type == .mainNavbar
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        onClickBackButton?()
    }
}
