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

    // MARK: - Navigation

    /// Set Custom Navigation Bar
    /// - Parameter type: type of Navigation bar, with back button or main title
    func setNavbar(type: NavbarType) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationItem.titleView?.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false

        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.navigationItem.titleView = UIView()

        let backButton: UIButton = setCustomButton(image: UIImage(named: "back-arrow"), width: 20, height: 20, sender: #selector(self.onBackAction))
        let homeButton = setCustomButton(image: UIImage(named: "home"), width: 25, height: 25, sender: #selector(self.onHomeAction))

        if type == .mainNavbar {
            titleLabel.text = "BandungTimes"
            self.navigationItem.titleView = titleLabel
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)
        }
    }

    private func setCustomButton(image: UIImage?, width: CGFloat, height: CGFloat, sender: Any) -> UIButton {
        let customButton: UIButton = UIButton()
        customButton.addTarget(self, action: sender as! Selector, for: UIControl.Event.touchUpInside)
        customButton.setImage(image, for: .normal)
        customButton.translatesAutoresizingMaskIntoConstraints = true
        customButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: height).isActive = true

        return customButton
    }

    @objc private func onBackAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func onHomeAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
