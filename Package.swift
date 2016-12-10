import PackageDescription

let package = Package(
    name: "SwifTumb",
    dependencies: [
        .Package(url: "git@github.com:Alamofire/Alamofire.git", majorVersion: 4)
    ]
)
