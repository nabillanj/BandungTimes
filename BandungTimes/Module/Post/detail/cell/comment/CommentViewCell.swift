//
//  CommentViewCell.swift
//  BandungTimes
//
//  Created by nabilla on 28/08/21.
//

import UIKit

class CommentViewCell: UITableViewCell {

    @IBOutlet weak var lblCommentName: UILabel!
    @IBOutlet weak var lblCommentDescription: UILabel!
    @IBOutlet weak var viewCommentCircle: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewCommentCircle.layer.cornerRadius = viewCommentCircle.bounds.width / 2
    }

    func bind(comment: Comment) {
        lblCommentName.text = comment.email + " :"
        lblCommentDescription.text = comment.body
    }
}
