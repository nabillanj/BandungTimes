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
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var viewSummaryComment: UIView!
    @IBOutlet weak var lblSummaryComment: UILabel!

    private var viewModel = PostDetailViewModel()
    private var userViewModel = UserViewModel()

    private var user: User?

    var idPost: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbar(type: .backNavbar)
        setupUI()
        setupViewModel()
    }

    private func setupUI() {
        viewSummaryComment.layer.cornerRadius = 8
        viewComment.layer.cornerRadius = 8
        viewComment.layer.borderWidth = 1
        viewComment.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor

        tableView.tableFooterView = UIView()
        tableView.register(PostDetailViewCell.nib, forCellReuseIdentifier: PostDetailViewCell.identifier)
        tableView.register(CommentViewCell.nib, forCellReuseIdentifier: CommentViewCell.identifier)
        tableView.register(PostListViewCell.nib, forCellReuseIdentifier: PostListViewCell.identifier)
        tableView.register(PostDetailHeader.nib, forHeaderFooterViewReuseIdentifier: PostDetailHeader.identifier)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    }

    private func setupViewModel() {
        viewModel.onSuccess = { [weak self] in
            self?.user = self?.userViewModel.filterUserById(id: self?.viewModel.post?.userId ?? 0)

            let comment = self?.viewModel.numberOfComment ?? 0
            // if comment more than 99, will showing 99+
            self?.lblSummaryComment.text = comment > 99 ? "99+" : "\(comment)"
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
    @IBAction func onClickToCommentSections(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: PostDetailType.comment.rawValue)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
            detailCell.delegate = self
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

extension PostDetailViewController: PostDetailDelegate {
    func onClickVisit() {
        let userVc = UserDetailViewController.instantiateFrom(storyboard: .user)
        userVc.user = user
        self.navigationController?.pushViewController(userVc, animated: true)
    }
}
