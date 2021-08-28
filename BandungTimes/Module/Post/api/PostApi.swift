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
        networkManager.connect(endpoint: PostEndpoint.detail(idPost: String(idPost)).endpoint, method: .get) { (result: Result<Post, Error>) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

    func getListCommentPost(idPost: Int, completionHandler: @escaping ([Comment]?, Error?) -> Void) {
        networkManager.connect(endpoint: PostEndpoint.listComment(idPost: String(idPost)).endpoint, method: .get) { (result: Result<[Comment], Error>) in
            switch result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }

    func getRelatedPost(idUser: Int, completionHandler: @escaping ([Post]?, Error?) -> Void) {
        networkManager.connect(endpoint: PostEndpoint.relatedPost(idUser: String(idUser)).endpoint, method: .get) { (result: Result<[Post], Error>) in
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
        case listComment(idPost: String)
        case relatedPost(idUser: String)

        var endpoint: String {
            switch self {
            case .list:
                return "/posts"
            case .detail(let idPost):
                return "/posts/" + idPost
            case .listComment(let idPost):
                return "/posts/" + idPost + "/comments"
            case .relatedPost(let idUser):
                return "/posts?userId=" + idUser
            }
        }
    }
}
