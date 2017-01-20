SwifTumb
=========
[![Build Status](https://travis-ci.org/ushios/SwifTumb.svg?branch=master)](https://travis-ci.org/ushios/SwifTumb)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4b083e309c4d4683b222ad1b7d51cc67)](https://www.codacy.com/app/ushios/SwifTumb?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ushios/SwifTumb&amp;utm_campaign=Badge_Grade)

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
- [user/likes](https://www.tumblr.com/docs/en/api/v2#m-ug-likes)
- [blog/xxx/posts](https://www.tumblr.com/docs/en/api/v2#posts)
- [blog/xxx/post/reblog](https://www.tumblr.com/docs/en/api/v2#reblogging)
