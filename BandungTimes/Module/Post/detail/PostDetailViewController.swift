//
//  PostDetailViewController.swift
//  BandungTimes
//
//  Created by nabilla on 27/08/21.
//

import UIKit

enum PostDetailType: Int, CaseIterable {
    case detail
    case relatedPost
    case comment
}

class PostDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel = PostDetailViewModel()
    private var userViewModel = UserViewModel()

    private var user: User?

    var idPost: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupViewModel()
    }

    private func setupTableview() {
        tableView.tableFooterView = UIView()
        tableView.register(PostDetailViewCell.nib, forCellReuseIdentifier: PostDetailViewCell.identifier)
        tableView.register(CommentViewCell.nib, forCellReuseIdentifier: CommentViewCell.identifier)
        tableView.register(PostListViewCell.nib, forCellReuseIdentifier: PostListViewCell.identifier)
        tableView.register(PostDetailHeader.nib, forHeaderFooterViewReuseIdentifier: PostDetailHeader.identifier)
    }

    private func setupViewModel() {
        viewModel.onSuccess = { [weak self] in
            self?.user = self?.userViewModel.filterUserById(id: self?.viewModel.post?.userId ?? 0)
            self?.tableView.reloadData()
        }

        viewModel.onShowError = { [weak self] error in
            self?.showAlertMessage(title: error)
        }

        userViewModel.getListUser { [weak self] (error) in
            if error == nil {
                let idPost =  self?.idPost ?? 0
                self?.viewModel.getDetailPost(idPost: idPost)
                self?.viewModel.getListComment(idPost: idPost)
            } else {
                self?.showAlertMessage(title: error ?? "", autoDismiss: false, completionHandler: nil)
            }
        }
    }

    // MARK: - Actions
    @IBAction func onClickVisitToWriter(_ sender: Any) {
        showAlertMessage(title: "Hola")
    }
}

extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return PostDetailType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch PostDetailType(rawValue: section) {
        case .detail:
            return 1
        case .relatedPost:
            return viewModel.numberOfRelatedPost
        default:
            return viewModel.numberOfComment
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch PostDetailType(rawValue: indexPath.section) {
        case .detail:
            let detailCell = tableView.dequeueReusableCell(withIdentifier: PostDetailViewCell.identifier) as! PostDetailViewCell
            detailCell.bind(post: viewModel.post, user: user)
            return detailCell
        case .relatedPost:
            let postCell = tableView.dequeueReusableCell(withIdentifier: PostListViewCell.identifier) as! PostListViewCell
            postCell.bind(post: viewModel.arrayOfRelatedPost[indexPath.row], user: user)
            return postCell
        default:
            let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentViewCell.identifier) as! CommentViewCell
            commentCell.bind(comment: viewModel.arrayOfComment[indexPath.row])
            return commentCell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostDetailHeader.identifier) as! PostDetailHeader
        headerView.bind(postDetailType: PostDetailType(rawValue: section) ?? .detail, numberOfComment: viewModel.numberOfComment)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch PostDetailType(rawValue: section) {
        case .detail:
            return 0
        default:
            return 50
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch PostDetailType(rawValue: indexPath.section) {
        case .relatedPost:
            let postDetailController = PostDetailViewController.instantiateFrom(storyboard: .post)
            postDetailController.idPost = viewModel.arrayOfRelatedPost[indexPath.row].id
            navigationController?.pushViewController(postDetailController, animated: true)
        default:
            break
        }
    }
}
