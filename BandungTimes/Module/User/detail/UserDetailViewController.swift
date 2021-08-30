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

        viewModel.getAlbumList(userId: user?.id ?? 0)
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

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.arrayOfAlbumPhotos.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch UserDetailType(rawValue: section) {
        case .detail:
            return 0
        default:
            return viewModel.arrayOfAlbumPhotos[section - 1].photos?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosViewCell.identifier, for: indexPath) as! PhotosViewCell

        let photos = viewModel.arrayOfAlbumPhotos[indexPath.section - 1].photos ?? []
        if photos.count > 0 {
            imageUserCell.bind(urlString: photos[indexPath.row].thumbnailUrl ?? "")
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
            let albumTitle = viewModel.arrayOfAlbumPhotos[indexPath.section - 1].album?.title ?? ""
            albumHeader.bind(title: albumTitle)

            return albumHeader
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch UserDetailType(rawValue: section) {
        case .detail:
            return CGSize(width: collectionView.bounds.width, height: 180)
        default:
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthImage = collectionView.bounds.width / 4
        return CGSize(width: widthImage, height: widthImage)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch UserDetailType(rawValue: indexPath.section) {
        case .album:
            let detailVc = PhotosPageViewController.instantiateFrom(storyboard: .user)
            detailVc.currentIndex = indexPath.row
            detailVc.photos = viewModel.arrayOfAlbumPhotos[indexPath.section - 1].photos ?? []
            self.navigationController?.pushViewController(detailVc, animated: false)
        default:
            break
        }
    }

}
