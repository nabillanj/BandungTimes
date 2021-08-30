//
//  PhotosPageViewController.swift
//  BandungTimes
//
//  Created by nabilla on 30/08/21.
//

import UIKit

class PhotosPageViewController: UIPageViewController {

    var photos: [Photos] = []
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = .black
        setViewControllers([viewPhotosDetail(index: currentIndex)], direction: .forward, animated: true, completion: nil)
        dataSource = self
        delegate = self
        setNavbar(type: .backNavbar)
    }

    // MARK: - Set view controller
    private func viewPhotosDetail(index: Int) -> PhotosDetailViewController {
        self.currentIndex = index

        let pageDetailVc = PhotosDetailViewController.instantiateFrom(storyboard: .user)
        pageDetailVc.photo = photos[currentIndex]
        return pageDetailVc
    }
}

extension PhotosPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex > 0 {
            return viewPhotosDetail(index: currentIndex - 1)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex + 1 < photos.count {
            return viewPhotosDetail(index: currentIndex + 1)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
