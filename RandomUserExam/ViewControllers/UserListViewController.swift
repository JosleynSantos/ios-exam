//
//  UserListViewController.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var userListViewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        configure()
        configureTableView()
    }
    
    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        userListViewModel.fetchUsers()
    }
    
    private func configureTableView() {
        usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.reloadData()
    }
    
    private func bindToViewModel() {
        userListViewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                if self?.userListViewModel.isLoading ?? false {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        userListViewModel.didSuccess = { [weak self]  in
            DispatchQueue.main.async {
                self?.usersTableView.reloadData()
            }
        }
        
        userListViewModel.didError = { [weak self]  in
            let alert = UIAlertController(title: "Error", message: "Try again later", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            DispatchQueue.main.async {
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func navigateToUserDetails(index: Int) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        guard let userDetailsVC = storyboard.instantiateViewController(identifier: "UserDetailsViewModel") as? UserDetailsViewController else {
            print("ViewController not found")
            return
        }
        let userDetailsVM = userListViewModel.generateUserDetailsViewModel(index: index)
        userDetailsVC.configure(viewModel: userDetailsVM)
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userListViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        let userDetailsVM = userListViewModel.generateUserDetailsViewModel(index: indexPath.row)
        cell.configure(viewModel: userDetailsVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == userListViewModel.numberOfRows - 1 && !userListViewModel.isLoading {
            userListViewModel.fetchUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToUserDetails(index: indexPath.row)
    }
}
