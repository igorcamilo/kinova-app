
# Kinova

[![Unit tests](https://github.com/igorcamilo/kinova-app/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/igorcamilo/kinova-app/actions/workflows/unit-tests.yml)
[![codecov](https://codecov.io/gh/igorcamilo/kinova-app/graph/badge.svg?token=0OPWWZTHAA)](https://codecov.io/gh/igorcamilo/kinova-app)

Kinova is a cross-platform SwiftUI app for browsing movies and TV shows, powered by [TMDB](https://www.themoviedb.org/) and built with modern Swift and async/await patterns. It supports iOS, macOS, and visionOS.

## Features

- Browse trending, popular, and top-rated movies and TV shows
- View detailed information and similar recommendations
- Carousel-based navigation for content discovery
- Responsive UI for iOS, macOS, and visionOS
- Async data loading and modern Swift concurrency
- Code coverage and CI with GitHub Actions and Codecov

## Getting Started

### Prerequisites

- Xcode 16.4 or later
- A TMDB API access token

### Setup

1. **Clone the repository:**
	```sh
	git clone https://github.com/igorcamilo/kinova-app.git
	cd kinova-app
	```

2. **Configure Secrets:**
	- Set the `TMDB_ACCESS_TOKEN` environment variable with your TMDB API token.
	- Run the provided script to generate the secrets file:
	  ```sh
	  export TMDB_ACCESS_TOKEN=your_token_here
	  ./Scripts/CreateSecretsFile.sh
	  ```

3. **Open in Xcode:**
	- Open `Kinova.xcodeproj` in Xcode.

4. **Build and Run:**
	- Select your target platform (iOS, macOS, or visionOS) and run the app.

## Project Structure

- `Kinova/` — Main app source code (SwiftUI views, view models, configuration)
- `KinovaTests/` — Unit tests
- `Scripts/` — Utility scripts (e.g., secrets file generation)
- `.github/workflows/` — CI/CD workflows for linting, testing, and security
- `.editorconfig` — Editor configuration for consistent code style

## Development

- Uses [tmdb-swift](https://github.com/igorcamilo/tmdb-swift) as a Swift Package dependency.
- Modern SwiftUI patterns, including `@Observable`, async/await, and environment objects.
- Custom carousel and navigation components for a smooth browsing experience.

## Testing

- Run unit tests with:
  ```sh
  xcodebuild test -project Kinova.xcodeproj -scheme Kinova
  ```
- CI runs tests on iOS, macOS, and visionOS simulators and uploads coverage to Codecov.

## Code Style

- 2-space indentation and Unix line endings enforced via `.editorconfig`.
- Linting is automated in CI with Swift Format.

## License

MIT License. See [LICENSE](LICENSE).

## Acknowledgments

- [TMDB](https://www.themoviedb.org/) for the movie/TV data API
- [tmdb-swift](https://github.com/igorcamilo/tmdb-swift) for the Swift client library

---

> This project is not affiliated with TMDB. You need your own TMDB API access token.
