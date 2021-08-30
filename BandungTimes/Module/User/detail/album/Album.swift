//
//  Album.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import Foundation

class Album: Decodable, Hashable {

    required init?(jsonData: Data?) {

    }

    required init?(jsonString: String) {

    }

    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.userId)
        hasher.combine(self.title)
    }

    var id, userId: Int?
    var title: String?
}
