// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let Cloud = Target.Dependency(stringLiteral: "Cloud")
private let DesignSystem = Target.Dependency(stringLiteral: "DesignSystem")
private let FilmographyManager = Target.Dependency(stringLiteral: "FilmographyManager")
private let Utilities = Target.Dependency(stringLiteral: "Utilities")

let package = Package(name: "Modules",

                      platforms: [.iOS(.v16)],

                      products: [.library(name: "Filmography",
                                          targets: ["Filmography"])],

                      targets: [.target(name: "Cloud",
                                        dependencies: [Utilities]),

                                .target(name: "DesignSystem",
                                        dependencies: []),

                                .target(name: "Filmography",
                                        dependencies: [DesignSystem, FilmographyManager]),

                                .target(name: "FilmographyManager",
                                        dependencies: [Cloud, Utilities]),

                                .target(name: "Utilities",
                                        dependencies: []),

                                .testTarget(name: "FilmographyManagerTests",
                                            dependencies: [Cloud, FilmographyManager, Utilities])]
)
