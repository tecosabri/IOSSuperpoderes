//
//  NetworkManager.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation


let server = "https://gateway.marvel.com"

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
}

enum EndPoints: String {
    case characters = "/v1/public/characters"
    case series = "/v1/public/characters/{characterId}/series"
}

protocol NetworkHelperProtocol: AnyObject {
    
}

class NetworkHelper: NetworkHelperProtocol {
    
    
}
