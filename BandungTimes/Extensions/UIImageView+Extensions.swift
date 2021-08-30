//
//  UIImageView+Extensions.swift
//  BandungTimes
//
//  Created by nabilla on 30/08/21.
//

import UIKit
import AlamofireImage

extension UIImageView {


    /// Load Image from Url
    /// - Parameter urlString: string of url for the images
    func loadImage(urlString: String) {
        let imageCache = AutoPurgingImageCache()
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            if let cachedAvatarImage = imageCache.image(for: urlRequest, withIdentifier: urlString) {
                self.image = cachedAvatarImage
            } else {
                self.af.setImage(withURL: url)
            }
        } else {
            self.image = nil
        }
    }
}
