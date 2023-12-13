//
//  EndPoint.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

protocol EndPointProtocol {
    var baseURL : String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var queryItems: [URLQueryItem]? { get }
    
    func request() -> URLRequest
}

enum EndPoint {
    case fetchPokemonData
}

extension EndPoint : EndPointProtocol {
    var baseURL: String {
        return BASE_URL
    }
    
    var path: String {
        switch self {
        case .fetchPokemonData:
            return PATH
        }
    }
    
    var method: HTTPMethodType {
        switch self {
        case .fetchPokemonData:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchPokemonData:
            return [
                URLQueryItem(name: "offset", value: "0"),
                URLQueryItem(name: "limit", value: "25")
            ]
        }
    }
    
    func request() -> URLRequest {
        var urlComponents = URLComponents(string: baseURL + path)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            fatalError("URL oluşturulamadı")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    
}
