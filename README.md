# GoogleStyleSwiftUI


![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-1.0.0-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-Supported-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-macOS_12.0|iOS_16.0-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)

## Feature
* [x] TextField
* [x] SecureField
* [x] Multiline TextField
* [x] TextEditor / TextView
* [x] TextField - limitCount, prompt
* [x] Refactor - SecureField
* [ ] Fix - padding()
* [ ] Picker
* [ ] DatePicker
* [ ] DatePicker - Lunar Segment
* [ ] Configure Style Appearance - Color, Font
* [x] Swift Package Manager

![Image](https://drive.google.com/uc?export=view&id=1hMiMVD3qbRP6fWTKKsp4H7ASxYneAo1M)  

## Requirements
* iOS 16.0+
* macOS 12.0+
* Swift 5.9+

## Installation
```swift
dependencies: [
  .package(url: "https://github.com/swift-man/GoogleStyleSwiftUI.git", from: "1.0.0")
]
```

Add `GoogleStyleSwiftUI` to your target dependencies.

## TextField
`limit` 기본값은 `100`이며, `0` 이하 값은 안전한 최소값인 `1`로 정규화됩니다.

```swift
import SwiftUI
import GoogleStyleSwiftUI

struct ContentView: View {
  @State var text = ""
  @State var errorMessage = ""
  @FocusState var isFocused: Bool

  var body: some View {
    GSTextField(text: $text,
                limit: 10,
                placeholder: "사용자 이름",
                editingPlaceholder: "10자리",
                isFocused: $isFocused,
                errorMessage: $errorMessage,
                description: "문자, 숫자, 마침표를 사용할 수 있습니다.")
      .padding(EdgeInsets(top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 10))
  }
}
```

## Multiline TextField
`GSMultilineTextField`는 iOS 16 이상에서 세로 확장 입력을 지원합니다.

```swift
import SwiftUI
import GoogleStyleSwiftUI

struct MemoView: View {
  @State var text = ""
  @State var errorMessage = ""
  @FocusState var isFocused: Bool

  var body: some View {
    GSMultilineTextField(text: $text,
                         limit: 4000,
                         placeholder: "내용",
                         editingPlaceholder: "엔터로 줄바꿈",
                         isFocused: $isFocused,
                         errorMessage: $errorMessage,
                         lineLimit: 1...8)
  }
}
```

## TextView
`GSTextView`는 SwiftUI `TextEditor` 기반의 긴 본문 입력을 지원합니다. SwiftUI 이름을 선호하면 `GSTextEditor` alias를 사용할 수 있습니다.

```swift
import SwiftUI
import GoogleStyleSwiftUI

struct ArticleView: View {
  @State var text = ""
  @State var errorMessage = ""
  @FocusState var isFocused: Bool

  var body: some View {
    GSTextView(text: $text,
               limit: 4000,
               placeholder: "본문",
               editingPlaceholder: "내용을 입력하세요.",
               isFocused: $isFocused,
               errorMessage: $errorMessage,
               description: "긴 문장을 입력할 수 있습니다.",
               minHeight: 140)
  }
}
```

## SecureField
```swift
import SwiftUI
import GoogleStyleSwiftUI

struct ContentView: View {
  @State var text = ""
  @State var errorMessage = ""
  @FocusState var isFocused: Bool

  var body: some View {
    GSSecureField(text: $text,
                  placeholder: "비밀번호",
                  isFocused: $isFocused,
                  errorMessage: $errorMessage)
  }
}
```
