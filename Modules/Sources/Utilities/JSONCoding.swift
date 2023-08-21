//
//  JSONCoding.swift
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

public func encodeToJSON(object: some Encodable) -> [String: Any]? {
    let encoder = JSONEncoder()
    let data = try! encoder.encode(object)
    return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
}
