//
//  User.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation

struct User: Decodable {
    var id: Int?
    var name, username, email: String?
    var address: UserAddress?
    var phone, website: String?
    var company: UserCompany?
}
