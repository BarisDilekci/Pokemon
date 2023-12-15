//
//  NetworkManager.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

protocol INetworkManager {
    func request<T: Decodable>(_ endpoint: EndPoint, completion: @escaping (Swift.Result<T, Swift.Error>) -> ())
}

final class NetworkManager: INetworkManager {
    var session: URLSession = URLSession.shared

    func request<T>(_ endpoint: EndPoint, completion: @escaping (Swift.Result<T, Error>) -> ()) where T: Decodable {
        let task = session.dataTask(with: endpoint.request()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid response", code: 0)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid response data", code: 0)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
