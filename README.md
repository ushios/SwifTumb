SwifTumb
=========
Tumblr client written by open source swift

Installation
============

### SwiftPM

```swift
dependencies: [
    .Package(url: "https://github.com/ushios/SwifTumb.git", majorVersion: 0)
]
```

Examples
========

### Using [user/dashboard](https://www.tumblr.com/docs/en/api/v2#m-ug-dashboard) api

```swift
import SwifTumb

let client = SwifTumb(
    consumerKey: "",
    consumerSecret: "",
    oauthToken: "",
    oauthTokenSecret: ""
)

let handle = try! client.userDashboard(success: { (response: SwifTumbResponse) in
    print(response.meta.status) // 200
    print(response.response!.posts![0].blogName) // Print first blog_name of post list
}) { (error) in
    // error code
}

```

Testing and development
====================

```bash
$ export SWIFTUMB_CONSUMER_KEY=""
$ export SWIFTUMB_CONSUMER_SECRET=""
$ export SWIFTUMB_OAUTH_TOKEN=""
$ export SWIFTUMB_OAUTH_TOKEN_SECRET=""
$ swift test
```

or create xcode project file using `swift package generate-xcodeproj` command and set environments on xcode.


Implemented list
==================

- [user/info](https://www.tumblr.com/docs/en/api/v2#m-up-info)
- [user/dashboard](https://www.tumblr.com/docs/en/api/v2#m-ug-dashboard)
