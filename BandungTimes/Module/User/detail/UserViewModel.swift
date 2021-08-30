//
//  UserViewModel.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import Foundation

struct UserPhotosAlbum {
    var album: Album?
    var photos: [Photos]?
}

class UserViewModel {
    var onSuccess: (() -> Void)?
    var onShowError: ((_ error: String) -> Void)?

    var arrayOfUser: [User] = []
    private var arrayOfAlbum: [Album] = []
    var arrayOfAlbumPhotos: [UserPhotosAlbum] = []

    var arrayOfPhotosAlbum: [UserPhotosAlbum] = []

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

                listAlbum?.forEach {
                    self.arrayOfAlbum.append($0)
                }
                self.getPhotosFromAlbum()
            } else {
                self.onShowError?(error?.localizedDescription ?? "")
            }
        }
    }

    private func getPhotosFromAlbum() {
        for album in arrayOfAlbum {
            userApi?.getPhotosFromAlbum(albumId: album.id ?? 0, completionHandler: { (photos, error) in
                if !self.arrayOfAlbumPhotos.contains(where: { $0.album?.id == album.id }) {
                    let userPhotosAlbum = UserPhotosAlbum(album: album, photos: photos)
                    self.arrayOfAlbumPhotos.append(userPhotosAlbum)
                }

                if self.arrayOfAlbumPhotos.count == self.arrayOfAlbum.count {
                    if error == nil {
                        self.onSuccess?()
                    } else {
                        self.onShowError?(error?.localizedDescription ?? "")
                    }
                    return
                }
            })
        }
    }

    func filterUserById(id: Int) -> User? {
        return arrayOfUser.filter{ $0.id == id }.first
    }
}
