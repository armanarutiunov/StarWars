// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let Cloud = Target.Dependency(stringLiteral: "Cloud")
private let StarWarsManager = Target.Dependency(stringLiteral: "StarWarsManager")
private let Utilities = Target.Dependency(stringLiteral: "Utilities")

let package = Package(name: "Cloud",

                      platforms: [.iOS(.v16)],

                      products: [.library(name: "Filmography",
                                          targets: ["Filmography"])],

                      targets: [.target(name: "Cloud",
                                        dependencies: [Utilities]),

                                .target(name: "Filmography",
                                        dependencies: [StarWarsManager]),

                                .target(name: "StarWarsManager",
                                        dependencies: [Cloud]),

                                .target(name: "Utilities",
                                        dependencies: [])]
)
