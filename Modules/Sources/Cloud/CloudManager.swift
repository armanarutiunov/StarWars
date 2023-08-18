//
//  CloudManager.swift
//  
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Foundation
import Utilities

public protocol CloudManageable {

    func request<T: Decodable>(with configuration: RequestConfiguration) async throws -> T
}

public final class CloudManager {

    // MARK: - Properties

    public static let shared = CloudManager()

    // MARK: - Life Cycle

    private init() {}

    // MARK: - Actions

    @MainActor
    public func request<T: Decodable>(with configuration: RequestConfiguration) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: configuration.urlRequest)
        return try data.decoded()
    }
}
