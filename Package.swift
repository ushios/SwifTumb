import PackageDescription

let package = Package(
    name: "SwifTumb",
    dependencies: [
        .Package(url: "https://github.com/OAuthSwift/OAuthSwift.git", majorVersion: 1)
    ]
)
