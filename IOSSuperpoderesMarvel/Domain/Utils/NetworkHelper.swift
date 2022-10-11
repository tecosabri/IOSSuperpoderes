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

enum Parameters: String {
    case apikey = "apikey"
    case timestamp = "ts"
    case md5 = "hash"
    case order = "orderBy"
}

enum Order: String {
    case nameAscending = "name"
    case modifiedAscending = "modified"
    case nameDescending = "-name"
    case modifiedDescending = "-modified"
}

protocol NetworkHelperProtocol: AnyObject {
    
}

class NetworkHelper: NetworkHelperProtocol {
    
    func getSessionCharacters(filter: String = "", inOrder order: Order) -> URLRequest? {
        // Get the URL with server + endpoint for characters + apikey + timestamp + md5 + order
        guard let authentication = try? AuthenticationHelper.generateMD5(),
              let md5Code = authentication.md5Code else { return nil }
        let stringURL = """
            \(server)\(EndPoints.characters.rawValue)?
            \(Parameters.apikey.rawValue)=\(AuthenticationHelper.publicKey)&
            \(Parameters.timestamp.rawValue)=\(authentication.timeStamp)&
            \(Parameters.md5.rawValue)=\(md5Code)&
            \(Parameters.order.rawValue)=\(order.rawValue)
            """
        guard let url = URL(string: stringURL) else { return nil }
        
        // Get the URL reques and add body if needed
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        if filter.count != 0 {
            request.httpBody = try? JSONEncoder().encode(CharacterFilter(filter: filter))
        }
        
        return request
    }
    
}
