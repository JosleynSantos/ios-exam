//
//  UserDetailsViewController.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    var viewModel: UserDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configure(viewModel: UserDetailsViewModel) {
        self.viewModel = viewModel
    }
    private func configureViews() {
        DispatchQueue.main.async {
            self.title = "User Details"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.userImageView.setRoundedCorners(radius: self.userImageView.frame.width / 2)
            self.userImageView.kf.setImage(with: self.viewModel.largeImageURL)
            self.nameLabel.text = self.viewModel.name
            self.genderLabel.text = self.viewModel.gender.uppercased()
            self.ageLabel.text = "\(self.viewModel.age)"
            self.birthdayLabel.text = self.viewModel.birthday
            self.addressLabel.text = self.viewModel.address
            self.mobileNumberLabel.text = self.viewModel.mobileNumber
            self.emailAddressLabel.text = self.viewModel.emailAddress
        }
    }
}
