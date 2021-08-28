//
//  PostDetailViewModel.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation

class PostDetailViewModel {
    var onSuccess: (() -> Void)?
    var onShowError: ((_ error: String) -> Void)?

    private var postApi: PostApi?
    var post: Post?

    var arrayOfComment: [Comment] = []
    var numberOfComment: Int {
        return arrayOfComment.count
    }

    var arrayOfRelatedPost: [Post] = []
    var numberOfRelatedPost: Int {
        return arrayOfRelatedPost.count
    }

    init(postApi: PostApi = PostApi()) {
        self.postApi = postApi
    }

    func getDetailPost(idPost: Int) {
        postApi?.getDetailPost(idPost: idPost, completionHandler: { (post, error) in
            if error == nil {
                self.post = post
                self.getRelatedPost(idUser: post?.userId ?? 0)
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        })
    }

    func getListComment(idPost: Int) {
        postApi?.getListCommentPost(idPost: idPost, completionHandler: { (arrayOfComment, error) in
            if error == nil {
                self.arrayOfComment = arrayOfComment ?? []
                self.onSuccess?()
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        })
    }

    func getRelatedPost(idUser: Int) {
        postApi?.getRelatedPost(idUser: idUser, completionHandler: { (listPost, error) in
            if error == nil {
                listPost?.forEach { self.arrayOfRelatedPost.append($0) }
                self.onSuccess?()
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        })
    }
}
