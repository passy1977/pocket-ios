# pocket-ios

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/passy1977/pocket-ios)
![Platform](https://img.shields.io/badge/platform-iOS%2018%2B-blue?logo=apple)
![Language](https://img.shields.io/badge/language-Swift%20%7C%20Obj--C%2B%2B-orange?logo=swift)
![License](https://img.shields.io/github/license/passy1977/pocket-ios)

Native iOS client for **Pocket** — a wallet for the secure storage of credentials and passwords.

## Overview

Pocket iOS is a secure credential management application built for iPhone and iPad. It stores, organizes, and protects sensitive information in an **encrypted, hierarchical structure** (Users → Groups → Fields), powered by the [Pocket Lib](https://github.com/passy1977/pocket-lib) C++ core through a Swift/Objective-C++ bridge.

Key characteristics:

- **Offline-first**: credentials are stored locally with full encryption, no network connection required
- **Optional sync**: can connect to a Pocket backend to synchronize credentials across devices
- **Auto-logout**: configurable session timeout automatically locks the app after inactivity
- **Keychain integration**: sensitive session data is stored using the iOS Keychain
- **Password generator**: built-in utility for generating strong passwords
- **Import / Export**: credentials can be exported and imported in JSON format

## Architecture

The app follows an **MVC** pattern and is structured in three layers:

| Layer | Technology | Responsibility |
|---|---|---|
| UI | Swift + UIKit | ViewControllers, navigation, user interaction |
| Bridge | Objective-C++ | Wraps the C++ pocket-lib for use in Swift |
| Core | C++ (pocket-lib) | Cryptography, data model, network communication |

The bridge layer (`Bridge/`) exposes `User`, `Group`, `Field`, `GroupController`, and `FieldController` classes to Swift via the bridging header.

## Requirements

- iOS 18.0+
- Xcode 15+

## Dependencies

| Library | Purpose |
|---|---|
| [openssl-ios](https://github.com/tls-inspector/openssl-ios) | Cryptographic operations |
| [curl-ios](https://github.com/tls-inspector/curl-ios) | HTTP networking |
| [SwiftSpinner](https://github.com/icanzilb/SwiftSpinner) | Loading indicators |
| [KeychainSwift](https://github.com/evgenyneu/keychain-swift) | Secure Keychain access |
| [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) | Keyboard handling |
| [Reachability.swift](https://github.com/ashleymills/Reachability.swift) | Network status detection |

## Pocket Ecosystem

### Core Components

- **[Pocket Backend](https://github.com/passy1977/pocket-backend)** - Java/Spring Boot backend service providing REST APIs, authentication, and business logic
- **[Pocket Web Backend](https://github.com/passy1977/pocket-web-backend)** - Rust/Actix web server with rate limiting and session management
- **[Pocket Lib](https://github.com/passy1977/pocket-lib)** - C++ core library for performance-critical operations and cryptography

### Client Applications

- **[Pocket Web Frontend](https://github.com/passy1977/pocket-web-frontend)** - Modern web interface for browser-based access
- **[Pocket CLI](https://github.com/passy1977/pocket-cli)** - Command-line tools for user and device management
- **[Pocket iOS](https://github.com/passy1977/pocket-ios)** - Native iOS client (this repository)
