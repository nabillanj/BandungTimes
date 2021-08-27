//
//  PostApi.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation

class PostApi {
    private let networkManager = NetworkManager()

    func getListPost(completionHandler: @escaping ([Post]?, Error?) -> Void) {
        networkManager.connect(endpoint: PostEndpoint.list.endpoint, method: .get) { (result: Result<[Post], Error>) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

    func getDetailPost(idPost: Int, completionHandler: @escaping (Post?, Error?) -> Void) {
        networkManager.connect(endpoint: PostEndpoint.detail(idPost: "\(idPost)").endpoint, method: .get) { (result: Result<Post, Error>) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

}

extension PostApi {
    enum PostEndpoint {
        case list
        case detail(idPost: String)

        var endpoint: String {
            switch self {
            case .list:
                return "/posts"
            case .detail(let idPost):
                return "/posts/" + idPost
            }
        }
    }
}
