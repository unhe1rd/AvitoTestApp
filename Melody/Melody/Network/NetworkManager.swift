//
//  Network.swift
//  Melody
//
//  Created by Mike Ulanov on 11.04.2024.
//

import Foundation
import UIKit

protocol SearchManagerDescription {
    func loadData(searchText: String, completion: @escaping (Result<iTunesResponse, Error>) -> Void)
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class SearchNetworkManager: SearchManagerDescription {
    
    static let shared: SearchManagerDescription = SearchNetworkManager()
    private init() {}
    
    let baseURL = NetworkConstants.baseURl
    
    func loadData(searchText: String, completion: @escaping (Result<iTunesResponse, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + "term=\(searchText)&limit=30") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print(url)

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(iTunesResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
