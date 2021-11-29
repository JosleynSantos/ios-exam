//
//  NetworkService.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/28/21.
//

import Foundation
import Alamofire

class NetworkServices {
    static let shared = NetworkServices()
    private let endpoint = "https://randomuser.me/api"
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return Session(configuration: configuration)
    }()
    
    // MARK: - Initialization
    private init() { }
    
    // MARK: - functions
    func request(params: [String: Any], completion: @escaping (Result<RandomUserResponse, Error>) -> Void) {
        sessionManager.request(endpoint, parameters: params).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let responseModel: RandomUserResponse? = self.dataToModel(data: data)
                if responseModel == nil {
                    completion(.failure(NSError(domain:"", code: response.response!.statusCode, userInfo:nil)))
                    return
                }
                completion(.success(responseModel!))
                return
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func dataToModel(data: Data) -> RandomUserResponse? {
        do {
            let genericModel = try JSONDecoder().decode(RandomUserResponse.self, from: data)
            return genericModel
        } catch let jsonErr {
            print(jsonErr)
            return nil
        }
    }
}
