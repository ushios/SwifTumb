import PackageDescription

let package = Package(
    name: "SwifTumb",
    dependencies: [
        .Package(url: "git@github.com:OAuthSwift/OAuthSwift", majorVersion: 1),
        .Package(url: "git@github.com:SwiftyJSON/SwiftyJSON.git", majorVersion: 3)
    ]
)
