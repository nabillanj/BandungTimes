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
        imgPhotos.layer.cornerRadius = 4
    }

    func bind(url: String) {
        imgPhotos.af_setImage(withURL: URL(string: url)!, placeholderImage: nil)
    }

}
