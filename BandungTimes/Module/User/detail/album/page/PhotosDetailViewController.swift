//
//  PhotosDetailViewController.swift
//  BandungTimes
//
//  Created by nabilla on 30/08/21.
//

import UIKit
import AlamofireImage

class PhotosDetailViewController: UIViewController {

    var photo: Photos?

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var imgPhotos: UIImageView!

    @IBOutlet weak var imgPhotosBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgPhotosLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgPhotosTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgPhotosTrailingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    private func setupUI() {
        scrollView.delegate = self
        imgPhotos.loadImage(urlString: photo?.url ?? "")

        lblTitle.text = photo?.title
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgPhotos
    }
}
