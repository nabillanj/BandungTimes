//
//  Comment.swift
//  BandungTimes
//
//  Created by nabilla on 28/08/21.
//

import Foundation

struct Comment: Decodable {
    var postId, id: Int
    var name, email, body: String
}
