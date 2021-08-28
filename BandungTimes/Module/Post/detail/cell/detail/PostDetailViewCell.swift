//
//  PostDetailViewCell.swift
//  BandungTimes
//
//  Created by nabilla on 28/08/21.
//

import UIKit

class PostDetailViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var lblWrittenBy: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var btnVisit: UIButton!
    @IBOutlet weak var imgWriter: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgWriter.layer.cornerRadius = imgWriter.bounds.width / 2
        btnVisit.layer.cornerRadius = 4
    }

    func bind(post: Post?, user: User?) {
        lblTitle.text = post?.title
        lblDescription.text = post?.body
        lblCompany.text = user?.company?.name
        lblWrittenBy.text = user?.name
    }
    
}
