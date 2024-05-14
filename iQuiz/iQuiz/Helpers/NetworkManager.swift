//
//  NetworkManager.swift
//  iQuiz
//
//  Created by Ahmed Ghaddah on 5/13/24.
//

import Foundation
class NetworkManager {
    static let shared = NetworkManager()

    func downloadData(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -2, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
