//
//  PhotosViewCell.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import UIKit
import AlamofireImage

class PhotosViewCell: UICollectionViewCell {

    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgPhotos: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(urlString: String) {
        let imageCache = AutoPurgingImageCache()
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            if let cachedAvatarImage = imageCache.image(for: urlRequest, withIdentifier: urlString) {
                imgPhotos.image = cachedAvatarImage
            } else {
                imgPhotos.af.setImage(withURL: url)
            }
        } else {
            imgPhotos = nil
        }
    }

}
