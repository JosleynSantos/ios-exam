//
//  RandomUserResponse.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import Foundation

struct RandomUserResponse: Decodable {
    var results: [User]?
    var info: Info?
    
    enum CodingKeys: String, CodingKey {
        case results
        case info
    }
}


struct Info: Decodable {
    var seed: String?
    
    enum CodingKeys: String, CodingKey {
        case seed
    }
}
