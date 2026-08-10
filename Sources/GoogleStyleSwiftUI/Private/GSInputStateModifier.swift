import SwiftUI

struct GSInputStateModifier: ViewModifier {
  private var isFocused: FocusState<Bool>.Binding

  @Binding
  private var text: String

  @Binding
  private var errorMessage: String

  @Binding
  private var color: Color

  @Binding
  private var isPlaceholderFloating: Bool

  private let characterLimit: Int?

  init(isFocused: FocusState<Bool>.Binding,
       text: Binding<String>,
       errorMessage: Binding<String>,
       color: Binding<Color>,
       isPlaceholderFloating: Binding<Bool>,
       characterLimit: Int? = nil) {
    self.isFocused = isFocused
    self._text = text
    self._errorMessage = errorMessage
    self._color = color
    self._isPlaceholderFloating = isPlaceholderFloating
    self.characterLimit = characterLimit.map { GSLimitPolicy.normalizedLimit($0) }
  }

  func body(content: Content) -> some View {
    content
      .focused(isFocused)
      .onAppear {
        enforceLimit(text)
        synchronizeState(isFocused: isFocused.wrappedValue,
                         errorMessage: errorMessage)
      }
      .onChange(of: isFocused.wrappedValue, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: newValue,
                           errorMessage: errorMessage)
        }
      })
      .onChange(of: errorMessage, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: isFocused.wrappedValue,
                           errorMessage: newValue)
        }
      })
      .onChange(of: text, perform: { newValue in
        enforceLimit(newValue)

        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: isFocused.wrappedValue,
                           errorMessage: errorMessage)
        }
      })
  }

  private func synchronizeState(isFocused: Bool, errorMessage: String) {
    isPlaceholderFloating = isFocused || !text.isEmpty
    color = GSInputColorPolicy.color(errorMessage: errorMessage,
                                     isFocused: isFocused)
  }

  private func enforceLimit(_ value: String) {
    guard let characterLimit else {
      return
    }

    let limitedText = GSLimitPolicy.limitedText(value, limit: characterLimit)
    guard limitedText != value else {
      return
    }

    text = limitedText
  }
}
