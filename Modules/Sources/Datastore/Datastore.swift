//
//  Datastore.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

import Foundation

public final class Datastore {

    // MARK: - Save

    public static func save<T: Codable>(_ object: T, key: String) {
        let path = Path<T>().item(key)
        let pathURL = URL(filePath: path)

        let archiver = NSKeyedArchiver(requiringSecureCoding: false)

        do {
            try archiver.encodeEncodable(object, forKey: key)
        } catch {
            print("⚠️ Failed to encode object: \(String(describing: T.self)) for key: \(key)")
            return
        }

        archiver.finishEncoding()

        let data = archiver.encodedData

        do {
            try data.write(to: pathURL)
        } catch {
            print("⚠️ Failed to write file for \(String(describing: T.self)) for key: \(key)")
            return
        }
    }

    // MARK: - Load

    public static func load<T: Codable>(key: String) -> T? {
        let path = Path<T>().item(key)

        guard let data = FileManager.default.contents(atPath: path) else {
            return nil
        }

        guard let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data) else {
            print("⚠️ Failed to create unarchiver for \(String(describing: T.self))")
            return nil
        }

        if let unarchivedObject = unarchiver.decodeDecodable(T.self, forKey: key) {
            unarchiver.finishDecoding()
            return unarchivedObject
        } else {
            print("⚠️ Failed to decode object for: \(String(describing: T.self))")
            delete(key: key, type: T.self)
            return nil
        }
    }

    // MARK: - Delete

    public static func delete<T: Codable>(key: String, type: T.Type) {
        let path = Path<T>().item(key)
        try? FileManager.default.removeItem(atPath: path)
    }

    public static func deleteAll<T: Codable>(of type: T.Type) {
        let path = Path<T>().folderPath
        try? FileManager.default.removeItem(atPath: path)
    }
}
