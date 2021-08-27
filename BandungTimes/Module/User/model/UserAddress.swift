//
//  UserAddress.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation

struct UserAddress: Decodable {
    var street, suite, city, zipcode: String?
    var geo: UserGeo?
}
