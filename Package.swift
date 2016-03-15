import PackageDescription

let package = Package (
    name: "SwiftGGAppServer",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0),
        .Package(url: "https://github.com/CoderAFI/Stencil.git", majorVersion: 0)
    ],
    exclude: [
      "Deploy",
      "Public",
      "Resources",
		  "Tests",
      "Database"
    ]
)
