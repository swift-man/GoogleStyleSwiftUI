# GoogleStyleSwiftUI

![Image](https://drive.google.com/uc?export=view&id=1hMiMVD3qbRP6fWTKKsp4H7ASxYneAo1M)  

## Feature
* [x] TextField
* [x] SecureField
* [ ] Refactor - padding(), SecureField
* [ ] Picker
* [ ] DatePicker
* [ ] DatePicker - Korean Lunar
* [ ] Configure Style - Color, Font
* [ ] SPM

## Code
```swift
import SwiftUI

struct ContentView: View {
  @State
  var text = ""

  @State
  var errorMessage = ""

  @FocusState
  private var isFocused: Bool

  var body: some View {
    GoogleStyleTextField(text: $text,
                         placeholder: "사용자 이름",
                         isFocused: $isFocused,
                         errorMessage: $errorMessage,
                         description: "문자, 숫자, 마침표를 사용할 수 있습니다.")
      .padding()
  }
}
```
