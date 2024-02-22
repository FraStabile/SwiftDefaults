# SwiftDefaults

SwiftDefaults is a Swift library designed to simplify user settings management in iOS applications. With SwiftDefaults, you can easily manage user preferences and customize the behavior of your app.

## Installation

To install SwiftDefaults in your project, simply add it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/SwiftDefaults.git", from: "1.0.0")
]
```

Then, add SwiftDefaults as a dependency for your target:

```swift
targets: [
    .target(
        name: "YourApp",
        dependencies: ["SwiftDefaults"])
]
```

Finally, run `swift build` to build your project and resolve dependencies.

## Usage

To start using SwiftDefaults in your app, follow these steps:

1. Import the SwiftDefaults module in your source files:

```swift
import SwiftDefaults
```

2. Set up user defaults:

```swift
SDM.current.userDefault = UserDefaults.standard
```

3. Optionally, set excluded keys:

```swift
SDM.current.setExcludedKey(exKey: ["Apple"])
```

4. Optionally, set highlighted keys:

```swift
SDM.current.setHighlightedKey(highlightedKey: ["test"])
```

5. Optionally, set color for highlighted keys:

```swift
SDM.current.setColorForHighlightedKey(color: .cyan)
```

6. Optionally, set gesture:

```swift
SDM.current.setGesture(.shake) // Enable shake gesture to access preferences from anywhere in the app
```

Or manually show/hide preferences:

```swift
SDM.current.setGesture(.none) // Manually add show/hide methods to access preferences
```

7. Start SwiftDefaults:

```swift
SDM.current.start()
```

## API

- `userDefault`: Set the UserDefaults instance to be used by SwiftDefaults.
- `setExcludedKey(exKey:)`: Exclude certain keys from being managed by SwiftDefaults.
- `setHighlightedKey(highlightedKey:)`: Specify keys to be highlighted.
- `setColorForHighlightedKey(color:)`: Set the color for highlighted keys.
- `setGesture(_ gestureType:)`: Set the type of gesture to access preferences (`shake` or `none`).
- `start()`: Start SwiftDefaults and begin managing user preferences.

## Example

```swift
import SwiftUI
import SwiftDefaults
@main
struct SwiftDefaultsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    SDM.current.userDefault = UserDefaults.standard
                    SDM.current.setExcludedKey(exKey: ["Apple"])
                    SDM.current.setHighlightedKey(highlightedKey: ["test"])
                    SDM.current.setColorForHighlightedKey(color: .cyan)
                    SDM.current.start()
                })
        }
    }
}
```

## License

SwiftDefaults is released under the MIT License. See `LICENSE` for details.
