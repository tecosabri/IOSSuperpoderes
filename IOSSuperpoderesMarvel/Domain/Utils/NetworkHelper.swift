//
//  NetworkManager.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 11/10/22.
//

import Foundation

/// The Marvel API base server url.
let server = "https://gateway.marvel.com"

/// The diferent HTTPMethods.
struct HTTPMethods {
    /// The post HTTP method.
    static let post = "POST"
    /// The get HTTP method.
    static let get = "GET"
    /// The put HTTP method.
    static let put = "PUT"
    /// The delete HTTP method.
    static let delete = "DELETE"
}

/// The different endpoints of the Marvel API.
enum EndPoint: String {
    /// The characters endpoint of the Marvel API.
    case characters = "/v1/public/characters"
    /// The series endpoint of the Marvel API where characterID has to be replaced by the character's id.
    case series = "/v1/public/characters/characterID/series"
}

/// The different parameter names needed to work with the Marvel API.
enum ParameterName: String {
    
    // Authentication parameters
    /// The api key parameter corresponding the public key.
    case apikey = "apikey"
    /// The timestamp parameter whose value has to be varaible on time, eg. a timestamp.
    case timestamp = "ts"
    /// The hash parameter corresponding to the md5 code of the string (ts+apikey+privateKey) being the privateKey the authentication private key.
    case md5 = "hash"
    
    // Other parameters
    /// A parameter that allows name filtering.
    case name = "name"
    /// A parameter that allows filtering by starting characters of a name.
    case nameStartsWith = "nameStartsWith"
    /// A parameter that allows filtering by the series where a character appears.
    case appearsInSeries = "series"
    /// A parameter that limits the returned results.
    case resultsLimit = "limit"
    /// A parameter that allows the call to skip a desired number of rresults.
    case skipResults = "offset"
    /// A parameter that allows to order the returned results.
    case order = "orderBy"
}

/// The order of the filtering.
enum Order: String {
    /// The order is ascending by name (a to the bottom).
    case nameAscending = "name"
    /// The order is ascending by the last modification (last modified to the top).
    case modifiedAscending = "modified"
    /// The order is descending by name (a to the top).
    case nameDescending = "-name"
    /// The order is descending by the last modification (last modified to the bottom).
    case modifiedDescending = "-modified"
}


/// A representation of a parameter of a HTTPRequest.
struct Parameter {
    /// The name of the parameter conforming to the API guidelines.
    let parameterName: ParameterName
    /// The value of the parameter conforming to the API guidelines.
    let value: String
}

/// Helper class  that generates URLSession and filters for all API calls regarding characters and series.
final class NetworkHelper {
    
    /// Gets the URLRequest to fetch characters with a given filter of parameters.
    /// - Parameter filter: The parameters that will filter the fetch request.
    /// - Returns: The URLRequest to fetch characters.
    static func getSessionCharacters(filter: [Parameter]?) -> URLRequest? {
        
        let stringURL = generateMarvelAPIUrl(fromEndPoint: .characters, andParameters: filter)
        guard let url = URL(string: stringURL) else { return nil }
        
        // Get the URL request and add body if needed
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    
    /// Gets the URLSession to fetch all series for a given character-
    /// - Parameter character: The character whose series' will be fetched.
    /// - Returns: The URLRequest to fetch all series for a given character.
    static func getSessionSeries(forCharacter character: Character) -> URLRequest? {
        var stringURL = generateMarvelAPIUrl(fromEndPoint: .series, andParameters: nil)
        stringURL = stringURL.replacingOccurrences(of: "characterID", with: String(character.id))
        guard let url = URL(string: stringURL) else { return nil }
        
        // Get the URL reques and add body if needed
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
    
    /// Generates a filter for a URLRequest.
    /// - Parameters:
    ///   - name: The parameter to filter by name-
    ///   - nameStartsWith: The parameter to filter by starting characters.
    ///   - resultsLimit: The parameter to limit the results fetched.
    ///   - skipResults: The parameter to offset the results fetched.
    /// - Returns: A list of parameters used to filter a URLRequest.
    static func generateFilterUsing(
        name: String? = nil,
        nameStartsWith: String? = nil,
        resultsLimit: Int? = nil,
        skipResults: Int? = nil) -> [Parameter] {
            var parameterList: [Parameter] = []
            // Adds parameters to the list depending on selected values for filter
            if let name { parameterList.append(Parameter(parameterName: .name, value: name))}
            if let nameStartsWith { parameterList.append(Parameter(parameterName: .nameStartsWith, value: nameStartsWith))}
            if let resultsLimit { parameterList.append(Parameter(parameterName: .resultsLimit, value: String(resultsLimit)))}
            if let skipResults { parameterList.append(Parameter(parameterName: .skipResults, value: String(skipResults)))}
            
            return parameterList
        }
    
    
    /// Generates a valid URL to fetch data from the Marvel API.
    /// - Parameters:
    ///   - endPoint: The end point of the desired data in the Marvel API.
    ///   - parameters: A list of parameters to filter the data.
    /// - Returns: The URL of the desired data.
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
        guard let stringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" } // Timestamp has spaces: it is needed to notify to URL(string:)
        
        return stringURL
    }
    
}
