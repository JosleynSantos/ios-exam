//
//  UserDetailsViewModel.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import Foundation

class UserDetailsViewModel {
    var model: User?
    
    init(user: User) {
        self.model = user
    }
    
    var name: String {
        return "\(model?.name?.firstName ?? "") \(model?.name?.lastName ?? "")"
    }
    
    var birthday: String {
        guard let birthdayString = model?.dateOfBirth?.birthday else {
            return "N/A"
        }
        return convertBirthdayFormat(birthdayString: birthdayString)
    }
    
    var age: Int {
        return model?.dateOfBirth?.age ?? getAgeFromBirthday(birthday: model?.dateOfBirth?.birthday)
    }
    
    var emailAddress: String {
        return model?.emailAddress ?? "N/A"
    }
    
    var mobileNumber: String {
        return model?.mobileNumber ?? "N/A"
    }
    
    var address: String {
        return "\(model?.address?.street?.number ?? 0000) \(model?.address?.street?.name ?? ""), \(model?.address?.city ?? ""), \(model?.address?.country ?? "")"
    }
    
    var mediumImageURL:  URL? {
        return model?.image?.medium ?? nil
    }
    
    var largeImageURL:  URL? {
        return model?.image?.large ?? nil
    }
    
    var gender: String {
        return model?.gender ?? "N/A"
    }
    
    private func convertBirthdayFormat(birthdayString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let theDate = dateFormatter.date(from: birthdayString)!
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: theDate)
    }
    
    private func getAgeFromBirthday(birthday: String?) -> Int {
        if birthday == nil { return 0 }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let birthdayDate = dateFormatter.date(from: birthday!)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let ageComponents = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = ageComponents.year
        return age ?? 0
    }
}
