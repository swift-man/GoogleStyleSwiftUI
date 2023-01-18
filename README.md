# GoogleStyleSwiftUI

![Image](https://drive.google.com/uc?export=view&id=1hMiMVD3qbRP6fWTKKsp4H7ASxYneAo1M)  

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
    GSTextField(text: $text1,
                limit: 10,
                placeholder: "사용자 이름",
                editingPlaceholder: "10자리",
                isFocused: $isFocused1,
                errorMessage: $errorMessage1,
                description: "문자, 숫자, 마침표를 사용할 수 있습니다.")
      .padding(EdgeInsets(top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 10))
      
    GSSecureField(text: $text2,
                  placeholder: "비밀번호",
                  isFocused: $isFocused2,
                  errorMessage: $errorMessage2)
              
  }
}
```
