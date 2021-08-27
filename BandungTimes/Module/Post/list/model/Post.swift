//
//  Post.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import Foundation

struct Post: Decodable {
    var userId, id: Int
    var title, body: String
}
