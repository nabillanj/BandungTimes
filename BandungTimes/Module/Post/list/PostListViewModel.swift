//
//  PostListViewModel.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import Foundation

class PostListViewModel  {

    var onSuccess: (() -> Void)?
    var onShowError: ((_ error: String) -> Void)?

    var arrayOfPostList: [Post] = []

    var numberOfRows: Int {
        return arrayOfPostList.count
    }

    private var postApi: PostApi?

    init(postApi: PostApi = PostApi()) {
        self.postApi = postApi
    }

    func getListPost() {
        postApi?.getListPost(completionHandler: { (listPost, error) in
            if error == nil {
                listPost?.forEach { self.arrayOfPostList.append($0) }
                self.onSuccess?()
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        })
    }
}
