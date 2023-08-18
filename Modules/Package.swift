// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "Modules",

                      platforms: [.iOS(.v16)],

                      products: [.library(name: "Modules", targets: ["Modules"])],

                      targets: [.target(name: "Modules",
                                        dependencies: []),

                                .testTarget(name: "ModulesTests",
                                            dependencies: ["Modules"])]
)
