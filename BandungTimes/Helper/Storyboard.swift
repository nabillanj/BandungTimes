//
//  Storyboard.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

enum Storyboard: String {

    case main
    case post
    case user

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: nil)
    }

    func viewController<T: UIViewController>(viewController: T.Type) -> T {
        let storyboardId = "\((viewController as UIViewController.Type).self)"
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }

}
