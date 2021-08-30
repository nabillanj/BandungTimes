//
//  UserDetailViewController.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import UIKit

enum UserDetailType: Int, CaseIterable {
    case detail
    case album
}

class UserDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private var viewModel = UserViewModel()

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }

    private func setupUI() {
        setNavbar(type: .backNavbar)
        collectionView.register(UserDetailViewCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserDetailViewCell.identifier)
        collectionView.register(AlbumHeader.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AlbumHeader.identifier)
        collectionView.register(PhotosViewCell.nib, forCellWithReuseIdentifier: PhotosViewCell.identifier)

        collectionView.reloadData()
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        collectionView.collectionViewLayout = layout

        viewModel.getAlbumList(userId: user?.id ?? 0)
        viewModel.getPhotosFromAlbum(albumId: 1)
    }

    private func setupViewModel() {
        viewModel.onSuccess = { [weak self] in
            self?.collectionView.reloadData()
        }

        viewModel.onShowError = { [weak self] error in
            self?.showAlertMessage(title: error)
        }
    }
}

extension UserDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch UserDetailType(rawValue: section) {
        case .detail:
            return 0
        default:
            return 10
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.arrayOfAlbum.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosViewCell.identifier, for: indexPath) as! PhotosViewCell

        if viewModel.arrayOfPhotos.count > 0 {
            imageUserCell.bind(url: "https://via.placeholder.com/150/92c952")
        }

        return imageUserCell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch UserDetailType(rawValue: indexPath.section) {
        case .detail:
            let detailView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserDetailViewCell.identifier, for: indexPath) as! UserDetailViewCell
            detailView.bind(user: user)

            return detailView
        default:
            let albumHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AlbumHeader.identifier, for: indexPath) as! AlbumHeader
            albumHeader.bind(title: viewModel.arrayOfAlbum[indexPath.section - 1].title ?? "")

            return albumHeader
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch UserDetailType(rawValue: section) {
        case .detail:
            return CGSize(width: collectionView.bounds.width, height: 160)
        default:
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width / 3)
    }

}
