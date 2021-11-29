//
//  UserListViewModel.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import Foundation
import Alamofire

class UserListViewModel{
    var users = [User]()
    var numberOfRows = 0
    var page = 1
    var isLoading: Bool  = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var didSuccess: (() -> Void)?
    var didError: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    private var params = [
        "results": 20,
        "inc": "name, dob, email, cell, location, picture, gender"
    ] as [String : Any]
    
}
extension UserListViewModel {
    func fetchUsers() {
        self.isLoading = true
        params["page"] = page
        NetworkServices.shared.request(params: params) {[weak self] (result)  in
            self?.isLoading = false
            switch result{
            case .success(let userResponse):
                guard let users = userResponse.results, users.count > 0 else {
                    self?.didError?()
                    return
                }
                self?.page += 1
                self?.users.append(contentsOf: users)
                self?.numberOfRows = self?.users.count ?? 0
                self?.params["seed"] = userResponse.info?.seed ?? "abc"
                self?.didSuccess?()
            case .failure(_):
                self?.didError?()
                return
            }
        }
    }
    
    func generateUserDetailsViewModel(index: Int) -> UserDetailsViewModel{
        let user = users[index]
        return UserDetailsViewModel(user: user)
    }
}
