# GoogleStyleSwiftUI


![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-0.0.0-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-planned-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-macOS_12.0|iOS_15.0-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)

## Feature
* [x] TextField
* [x] SecureField
* [x] TextField - limiteCount, prompt
* [x] Refactor - SecureField
* [ ] Fix - padding()
* [ ] Picker
* [ ] DatePicker
* [ ] DatePicker - Lunar Segment
* [ ] Configure Style Appearance - Color, Font
* [ ] SPM

![Image](https://drive.google.com/uc?export=view&id=1hMiMVD3qbRP6fWTKKsp4H7ASxYneAo1M)  

## TextField
```swift
import SwiftUI

struct ContentView: View {
  @State
  var text = ""

  @State
  var errorMessage = ""

  @FocusState
  var isFocused: Bool

  var body: some View {
    GSTextField(text: $text1,
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

## SecureField
```swift
import SwiftUI

struct ContentView: View {
  @State
  var text = ""

  @State
  var errorMessage = ""

  @FocusState
  var isFocused: Bool

  var body: some View {
    GSSecureField(text: $text,
                  placeholder: "비밀번호",
                  isFocused: $isFocused,
                  errorMessage: $errorMessage)
  }
}
```
