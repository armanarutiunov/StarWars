//
//  Error.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import Foundation

extension NSError {

    public static var unknown: NSError {
        NSError(domain: "com.wetransfer.wetransfer-error", code: 1)
    }
}
