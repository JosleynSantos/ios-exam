//
//  Person.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import Foundation


struct User: Decodable {
    var name: Name?
    var dateOfBirth: DateOfBirth?
    var emailAddress: String?
    var mobileNumber: String?
    var address: Location?
    var image: Image?
    var gender: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case dateOfBirth = "dob"
        case emailAddress = "email"
        case mobileNumber = "cell"
        case address = "location"
        case image = "picture"
        case gender
    }
}

// MARK: - Dict values

//name dictionary from result
struct Name: Decodable  {
    var firstName: String?
    var lastName: String?
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
}

//dob dictionary from result
struct DateOfBirth: Decodable  {
    var birthday: String?
    var age: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case birthday = "date"
        case age
    }
}

//location dictionary from result
struct Location: Decodable  {
    var street: Street?
    var city: String?
    var country: String?
    
    
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case country
    }
}

//street dictionary from location
struct Street: Decodable  {
    var number: Int?
    var name: String?
    
    
    enum CodingKeys: String, CodingKey {
        case number
        case name
    }
}


//picture dictionary from result
struct Image: Decodable  {
    var medium: URL?
    var large: URL?
    
    
    enum CodingKeys: String, CodingKey {
        case medium
        case large
    }
}
