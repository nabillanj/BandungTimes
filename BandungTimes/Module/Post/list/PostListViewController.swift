//
//  PostListViewController.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

class PostListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel = PostListViewModel()
    private var userViewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.title = "Bandung Times"
        setupViewModel()

        setNavbar(type: .mainNavbar)
        self.navigationController?.navigationBar.isHidden = false
        tableView.tableFooterView = UIView()
        tableView.register(PostListViewCell.nib, forCellReuseIdentifier: PostListViewCell.identifier)
        setupViewModel()
    }

    private func setupViewModel() {
        userViewModel.getListUser { (error) in
            if error == nil {
                self.viewModel.getListPost()
            } else {
                self.showAlertMessage(title: error ?? "", autoDismiss: false, completionHandler: nil)
            }
        }

        viewModel.onSuccess = {
            self.tableView.reloadData()
        }

        viewModel.onShowError = { error in
            self.showAlertMessage(title: error, autoDismiss: false, completionHandler: nil)
        }
    }
}

extension PostListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: PostListViewCell.identifier) as! PostListViewCell
        let postModel = viewModel.arrayOfPostList[indexPath.row]
        postCell.bind(post: postModel, user: userViewModel.filterUserById(id: postModel.userId))

        return postCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailController = PostDetailViewController.instantiateFrom(storyboard: .post)
        postDetailController.idPost = viewModel.arrayOfPostList[indexPath.row].id
        navigationController?.pushViewController(postDetailController, animated: true)
    }
}

