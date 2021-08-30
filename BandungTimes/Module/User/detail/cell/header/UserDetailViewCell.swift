//
//  UserDetailViewCell.swift
//  BandungTimes
//
//  Created by nabilla on 29/08/21.
//

import UIKit

class UserDetailViewCell: UICollectionReusableView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var imgUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.cornerRadius = imgUser.bounds.width / 2
    }

    func bind(user: User?) {
        lblTitle.text = user?.name
        lblCompany.text = "Company : " + (user?.company?.name ?? "")
        lblEmail.text = user?.email
    }
    
}
