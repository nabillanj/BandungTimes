//
//  UserViewModel.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation

class UserViewModel {
    var onSuccess: (() -> Void)?
    var onShowError: ((_ error: String) -> Void)?

    var arrayOfUser: [User] = []
    var arrayOfAlbum: [Album] = []
    var arrayOfPhotos: [Photos] = []

    private var userApi: UserApi?

    init(userApi: UserApi = UserApi()) {
        self.userApi = userApi
    }

    func getListUser(completionHandler: @escaping((String?) -> Void)) {
        userApi?.getListUser { (listUser, error) in
            if error == nil {
                listUser?.forEach { self.arrayOfUser.append($0) }
                completionHandler(nil)
            } else {
                completionHandler(error?.localizedDescription ?? "")
            }
        }
    }

    func getAlbumList(userId: Int) {
        userApi?.getAlbumList(userId: userId) { (listAlbum, error) in
            if error == nil {
                listAlbum?.forEach { self.arrayOfAlbum.append($0) }
                self.onSuccess?()
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        }
    }

    func getPhotosFromAlbum(albumId: Int) {
        userApi?.getPhotosFromAlbum(albumId: albumId) { (listPhotos, error) in
            if error == nil {
                listPhotos?.forEach { self.arrayOfPhotos.append($0) }
                self.onSuccess?()
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        }
    }

    func filterUserById(id: Int) -> User? {
        return arrayOfUser.filter{ $0.id == id }.first
    }
}
