# GitHub Repo Search — Objective-C

iOS GitHub repository search app built with Objective-C. Queries the GitHub Search API and displays results in a `UITableView` with dynamic-height cells via Auto Layout.

![Objective-C](https://img.shields.io/badge/Objective--C-iOS-000000?logo=apple&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-8%2B-1575F9?logo=xcode&logoColor=white)

---

## Features

- Search GitHub repositories by keyword using the GitHub v3 Search API
- Dynamic-height `UITableViewCell` via `UITableViewAutomaticDimension` and programmatic Auto Layout constraints
- Displays repository name, description, and star count per result

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Objective-C |
| UI | UIKit, UITableView, UITableViewAutomaticDimension, Auto Layout |
| Networking | NSURLSession / NSURLSessionDataTask |
| API | GitHub Search API v3 (`/search/repositories`) |

---

## Setup

```bash
open week3lab.xcodeproj
```

Build and run on the iOS Simulator (Xcode 8+). No dependencies or API keys required.
