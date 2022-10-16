//
//  AuthenticationHelper.swift
//  IOSSuperpoderesMarvel
//
//  Created by Ismael Sabri Pérez on 10/10/22.
//

import Foundation
import CryptoKit

/// Provides authentication for the Marvel API.
class AuthenticationHelper {
    
    static let privateKey = "106d4a90fd6df27742659f14d4c4a26015917214"
    static let publicKey = "5ed7dc76b420bc84a2d4a15450c50f4a"
    
    
    /// Generates the md5 code for (timestamp + privateKey + publicKey) and the current timestamp.
    /// - Returns: The md5 of the string formed by timestamp + privateKey + publicKey of the Marvel API and the current timestamp.
    static func generateMD5() throws -> (md5Code: String?, timeStamp: String) {
        // Get a string that changes in a request by request basis as the current timestamp
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = format.string(from: date)
        
        // Get a string for timestamp+privateKey+publicKey
        let md5OriginatorString = timestamp + privateKey + publicKey
        
        // Get the md5 code from the previous string
        let md5Code = md5OriginatorString.MD5
        
        return (md5Code, timestamp)
    }
}
