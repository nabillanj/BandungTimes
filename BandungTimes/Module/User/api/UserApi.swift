//
//  UserApi.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation
import Alamofire

class UserApi {
    private let networkManager = NetworkManager()

    func getListUser(completionHandler: @escaping ([User]?, Error?) -> Void) {
        networkManager.connect(endpoint: UserEndpoint.list.endpoint, method: .get) { (result: Result<[User], Error>) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}

extension UserApi {
    enum UserEndpoint {
        case list

        var endpoint: String {
            switch self {
            case .list:
                return "/users"
            }
        }
    }
}
