//
//  PostDetailHeader.swift
//  BandungTimes
//
//  Created by nabilla on 28/08/21.
//

import UIKit

class PostDetailHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lblHeaderTitle: UILabel!

    func bind(postDetailType: PostDetailType, numberOfComment: Int = 0) {
        switch postDetailType {
        case .comment:
            lblHeaderTitle.text = "See Comments (\(numberOfComment)): "
        case .relatedPost:
            lblHeaderTitle.text = "Related Post"
        default:
            break
        }
    }
}
