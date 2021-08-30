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
        imgPhotos.loadImage(urlString: urlString)
    }

}
