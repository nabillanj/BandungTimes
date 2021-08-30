//
//  Photos.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import Foundation

struct Photos: Decodable {
    var albumId, id: Int?
    var title, url, thumbnailUrl: String?
}
