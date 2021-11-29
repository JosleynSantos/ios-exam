//
//  UserTableViewCell.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    func configure(viewModel: UserDetailsViewModel) {
        containerView.dropShadowWithRoundedCorners()
        userImageView.setRoundedCorners(radius: userImageView.frame.height / 2)
        userImageView.kf.setImage(with: viewModel.mediumImageURL)
        nameLabel.text = viewModel.name
        mobileNumberLabel.text = viewModel.mobileNumber
        emailAddressLabel.text = viewModel.emailAddress
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
    }
    
}
