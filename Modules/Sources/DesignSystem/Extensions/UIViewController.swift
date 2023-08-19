//
//  UIViewController.swift
//  
//
//  Created by Arman Arutiunov on 19/08/2023.
//

import UIKit

extension UIViewController {

    /// Creates and presents a UIAlertController configured with the data from the error and a single "OK" action
    /// - Parameters:
    ///   - title: Title of the alert, defaults to "Sorry
    ///   - error: Error that causes the alert
    ///   - completion: Optional closure, triggered when user presses the OK button
    public func show(_ error: NSError, title: String = "Sorry", completion: (() -> Void)? = nil) {
        let alert: UIAlertController = .init(
            title: title,
            message: error.localizedRecoverySuggestion ?? error.localizedDescription,
            preferredStyle: .alert
        )

        alert.addAction(.init(title: "OK", style: .default, handler: { _ in
            completion?()
        }))

        present(alert, animated: true)
    }
}
