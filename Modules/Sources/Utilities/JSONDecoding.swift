//
//  JSONDecoding.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

import Foundation

public func decodeFromJSON<T: Decodable>(json: [String: Any?]) -> T? {
    let decoder = JSONDecoder()
    let data = try! JSONSerialization.data(withJSONObject: json)

    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Unable to parse: \(error)")
        return nil
    }
}
