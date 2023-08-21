//
//  Path.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

import Foundation

struct Path<T> {

    // MARK: - Properties

    let folderPath: String

    // MARK: - Life Cycle

    init() {
        let folderURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appending(path: "\(T.self)")

        do {
            if !FileManager.default.fileExists(atPath: folderURL.path) {
                let attributes = [FileAttributeKey(FileAttributeKey.protectionKey.rawValue): FileProtectionType.completeUntilFirstUserAuthentication]
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: attributes)
            }
            try (folderURL as NSURL).setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
        } catch {
            print("⚠️ Failed to create directory for \(T.self) in Caches")
        }

        self.folderPath = folderURL.path
    }

    // MARK: - Actions

    func item(_ key: String) -> String {
        URL(filePath: folderPath).appending(path: key).path
    }
}
