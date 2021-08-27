//
//  UIViewController+Extensions.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

extension UIViewController {

    /// Get Today Date
    /// - Parameter dateFormat: format for returned date
    /// - Returns: string of today date
    func getTodayDate(dateFormat: String = "EEEE, dd MMMM yyyy") -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        return format.string(from: Date())
    }

    /// Get App and build version
    /// - Returns: string of app version
    func getAppVersioning() -> String {
        return "v." + Bundle.main.getAppVersion() + "." + Bundle.main.getBuildVersion()
    }

    /// Function to initialize storyboard directly
    /// - Parameter storyboard: enum from Storyboard (based on the storyboard filename)
    /// - Returns: UIViewController
    static func instantiateFrom(storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewController: self)
    }



    /// Function to showing alert
    /// can be customized to automatically dismiss or need 1 action
    /// - Parameters:
    ///   - title: the title of alert
    ///   - autoDismiss: if true, will automatically dismiss in 2 seconds, otherwise will need action
    ///   - completionHandler: action for alert, optional
    func showAlertMessage(title: String = "", autoDismiss: Bool = true, completionHandler: ((()->Void)?) = nil) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)

        // if auto dismiss don't show any action
        // will automatically closed after 2 seconds
        if autoDismiss {
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alertController.dismiss(animated: true, completion: nil)
            }
        } else {
            let action = UIAlertAction(title: "ok", style: .default) { _ in
                if let completionHandler = completionHandler {
                    completionHandler()
                }
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
