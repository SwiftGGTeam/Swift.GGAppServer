import PackageDescription

let package = Package (
    name: "SwiftGGAppServer",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0)
    ],
    targets: [
        Target(
            name: "SwiftGGAppServer"
        ),
    ],
    exclude: [
        "Deploy",
        "Public",
        "Resources",
		"Tests",
		"Database"
    ]
)
