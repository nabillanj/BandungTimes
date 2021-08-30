//
//  AlbumHeader.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import UIKit

class AlbumHeader: UICollectionReusableView {

    @IBOutlet weak var lblTitleAlbum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(title: String) {
        lblTitleAlbum.text = title
    }
}
