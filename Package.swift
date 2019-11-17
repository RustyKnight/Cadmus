// swift-tools-version:5.1
//
//  Package.swift
//  iOS
//
//  Created by Shane Whitehead on 17/11/19.
//  Copyright © 2019 Kaizen Enteripises. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Cadmus",
    platforms: [
			.macOS(.v10_12), .iOS(.v10), .tvOS(.v11), .watchOS(.v4)
    ],
    products: [
        .library(name: "Cadmus", targets: ["Cadmus"]),
    ],
    dependencies: [
        //.package(url: "https://url/of/another/package/named/Utility", from: "1.0.0"),
    ],
    targets: [
			.target(name: "Cadmus", dependencies: [], path: "Sources/Cadmus"),
    ]
)
