//
//  SplashcreenViewController.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

class SplashcreenViewController: UIViewController {

    @IBOutlet weak var lblBandungTimes: UILabel!
    @IBOutlet weak var lblTodayDate: UILabel!
    @IBOutlet weak var lblVersion: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        lblTodayDate.text = getTodayDate()
        lblVersion.text = getAppVersioning()

        self.navigationController?.navigationBar.isHidden = true
    }

}
