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

    func getAlbumList(userId: Int, completionHandler: @escaping ([Album]?, Error?) -> Void) {
        networkManager.connect(endpoint: UserEndpoint.album(userId: String(userId)).endpoint, method: .get) { (result: Result<[Album], Error>) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

    func getPhotosFromAlbum(albumId: Int, completionHandler: @escaping ([Photos]?, Error?) -> Void) {
        networkManager.connect(endpoint: UserEndpoint.photos(albumId: String(albumId)).endpoint, method: .get) { (result: Result<[Photos], Error>) in
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
        case album(userId: String)
        case photos(albumId: String)

        var endpoint: String {
            switch self {
            case .list:
                return "/users"
            case .album(let userId):
                return "/albums?userId=" + userId
            case .photos(let albumId):
                return "/photos?albumId=" + albumId
            }
        }
    }
}
