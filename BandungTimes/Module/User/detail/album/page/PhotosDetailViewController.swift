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
        //updateMinZoomScaleForSize(view.bounds.size)
    }

    private func setupUI() {
        scrollView.delegate = self
        let imageCache = AutoPurgingImageCache()
        if let url = URL(string: photo?.url ?? "") {
            let urlRequest = URLRequest(url: url)
            if let cachedAvatarImage = imageCache.image(for: urlRequest, withIdentifier: photo?.url ?? "") {
                imgPhotos.image = cachedAvatarImage
            } else {
                imgPhotos.af.setImage(withURL: url)
            }
        } else {
            imgPhotos = nil
        }
        lblTitle.text = photo?.title
    }

    @IBAction func onDoubleClickImage(_ sender: Any) {
        if scrollView.zoomScale == 1 {
            scrollView.zoomScale = 20
        } else {
            scrollView.zoomScale = 1
        }
    }

    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imgPhotos.bounds.width
        let heightScale = size.height / imgPhotos.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }

    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imgPhotos.frame.height) / 2)
        imgPhotosTopConstraint.constant = yOffset
        imgPhotosBottomConstraint.constant = yOffset

        let xOffset = max(0, (size.width - imgPhotos.frame.width) / 2)
        imgPhotosLeadingConstraint.constant = xOffset
        imgPhotosTrailingConstraint.constant = xOffset

        view.layoutIfNeeded()
    }
}

extension PhotosDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgPhotos
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //updateConstraintsForSize(view.bounds.size)
    }
}

