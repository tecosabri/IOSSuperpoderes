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

enum EndPoint: String {
    case characters = "/v1/public/characters"
    case series = "/v1/public/characters/characterID/series"
}

enum ParameterName: String {
    // Authentication parameters
    case apikey = "apikey"
    case timestamp = "ts"
    case md5 = "hash"
    // Other parameters
    case name = "name"
    case nameStartsWith = "nameStartsWith"
    case appearsInSeries = "series"
    case resultsLimit = "limit"
    case skipResults = "offset"
    case order = "orderBy"
}

enum Order: String {
    case nameAscending = "name"
    case modifiedAscending = "modified"
    case nameDescending = "-name"
    case modifiedDescending = "-modified"
}

struct Parameter {
    let parameterName: ParameterName
    let value: String
}

protocol NetworkHelperProtocol: AnyObject {
    static func getSessionCharacters(filter: [Parameter]?) -> URLRequest?
    static func generateFilterUsing(name: String?, nameStartsWith: String?, appearsInSerie: String?, resultsLimit: Int?, skipResults: Int?, order: Order?) -> [Parameter]
}

final class NetworkHelper: NetworkHelperProtocol {
    
    static func getSessionCharacters(filter: [Parameter]?) -> URLRequest? {
        let stringURL = generateMarvelAPIUrl(fromEndPoint: .characters, andParameters: filter)
        guard let url = URL(string: stringURL) else { return nil }
       
        // Get the URL reques and add body if needed
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    static func getSessionSeries(forCharacter character: Character) -> URLRequest? {
        var stringURL = generateMarvelAPIUrl(fromEndPoint: .series, andParameters: nil)
        stringURL = stringURL.replacingOccurrences(of: "characterID", with: String(character.id))
        guard let url = URL(string: stringURL) else { return nil }
       
        // Get the URL reques and add body if needed
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    static func generateFilterUsing(
        name: String?,
        nameStartsWith: String?,
        appearsInSerie: String?,
        resultsLimit: Int?,
        skipResults: Int?,
        order: Order?) -> [Parameter] {
            var parameterList: [Parameter] = []
            // Adds parameters to the list depending on selected values for filter
            if let name { parameterList.append(Parameter(parameterName: .name, value: name))}
            if let nameStartsWith { parameterList.append(Parameter(parameterName: .nameStartsWith, value: nameStartsWith))}
            if let appearsInSerie { parameterList.append(Parameter(parameterName: .appearsInSeries, value: appearsInSerie))}
            if let resultsLimit { parameterList.append(Parameter(parameterName: .resultsLimit, value: String(resultsLimit)))}
            if let skipResults { parameterList.append(Parameter(parameterName: .skipResults, value: String(skipResults)))}
            if let order { parameterList.append(Parameter(parameterName: .order, value: order.rawValue))}
            
            return parameterList
        }
    
    
    private static func generateMarvelAPIUrl(fromEndPoint endPoint: EndPoint, andParameters parameters: [Parameter]?) -> String {
        // Create authentication parameters
        guard let authentication = try? AuthenticationHelper.generateMD5(),
              let md5Code = authentication.md5Code else { return "" }
        let keyParam = Parameter(parameterName: .apikey, value: AuthenticationHelper.publicKey)
        let tsParam = Parameter(parameterName: .timestamp, value: authentication.timeStamp)
        let md5Param = Parameter(parameterName: .md5, value: md5Code)
        // Add authentication parameters to parameters array
        var parametersCopy = [keyParam, tsParam, md5Param]
        parameters?.forEach { parameter in
            parametersCopy.append(parameter)
        }
      
        // Create string from server + endpoint + parameters
        var stringURL = "\(server)\(endPoint.rawValue)?"
        parametersCopy.forEach { parameter in
            stringURL.append(parameter.parameterName.rawValue)
            stringURL.append("=")
            stringURL.append(parameter.value)
            stringURL.append("&")
        }
    
        stringURL.removeLast() // Last & has to be removed from the string
        stringURL = stringURL.components(separatedBy: .newlines).joined() // Delete newlines created by multiline and interpolation
        guard let stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" } // Timestamp has spaces: it's needed to notify to URL(string:)
    
        return stringURL
    }
    
}
