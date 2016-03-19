import PackageDescription

let package = Package (
    name: "SwiftGGAppServer",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
        .Package(url: "https://github.com/novi/mysql-swift.git", majorVersion: 0),
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", majorVersion: 0),
        .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion: 2),
        .Package(url: "https://github.com/crossroadlabs/Regex.git", majorVersion: 0)
    ],
    exclude: [
        "Deploy",
        "Public",
        "Resources",
		"Tests",
		"Database"
    ]
)
