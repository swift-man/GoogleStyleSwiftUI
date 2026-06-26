# GoogleStyleSwiftUI

Build Google-style SwiftUI input components with floating placeholders, validation messaging, and length limits.

## Overview

`GoogleStyleSwiftUI` provides reusable SwiftUI form components for single-line, secure, multiline, and long-form text input.

Use ``GSTextField`` for standard text input and ``GSSecureField`` for password input. Use ``GSMultilineTextField`` when you want SwiftUI's multiline `TextField(axis: .vertical)` behavior, and use ``GSTextView`` for long-form `TextEditor`-based editing.

All text input components share the same public design goals:

- Floating placeholder behavior
- Validation error message support
- Optional editing placeholder text
- Safe length-limit normalization
- Swift Package Manager integration

```swift
import SwiftUI
import GoogleStyleSwiftUI

struct ContentView: View {
  @State private var text = ""
  @State private var errorMessage = ""
  @FocusState private var isFocused: Bool

  var body: some View {
    GSTextField(text: $text,
                limit: 100,
                placeholder: "Name",
                editingPlaceholder: "Enter your name",
                isFocused: $isFocused,
                errorMessage: $errorMessage)
  }
}
```

## Topics

### Text Input

- ``GSTextField``
- ``GSSecureField``
- ``GSMultilineTextField``
- ``GSTextView``

### Text Editing Alias

- ``GSTextEditor``
