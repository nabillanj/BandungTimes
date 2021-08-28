//
//  PostListViewCell.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

class PostListViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCompany: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        imageUser.layer.cornerRadius = imageUser.bounds.width / 2
    }

    func bind(post: Post, user: User?) {
        lblTitle.text = post.title
        lblDescription.text = post.body
        setUserData(user: user)
    }

    private func setUserData(user: User?) {
        lblUserName.text = "Written By: " + (user?.name ?? "")
        lblCompany.text = "Company: " + (user?.company?.name ?? "")
    }
    
}
