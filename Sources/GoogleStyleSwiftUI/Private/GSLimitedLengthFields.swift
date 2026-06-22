import SwiftUI
import LimitLengthTextField

struct GSLimitedLengthTextField: View {
  @Binding
  private var text: String

  private let characterLimit: Int

  init(text: Binding<String>, limit: Int) {
    self._text = text
    self.characterLimit = GSLimitPolicy.normalizedLimit(limit)
  }

  var body: some View {
    LimitLengthTextField(text: $text,
                         numberOfCharacterLimit: characterLimit)
  }
}

struct GSLimitedLengthSecureField: View {
  @Binding
  private var text: String

  private let characterLimit: Int

  init(text: Binding<String>, limit: Int) {
    self._text = text
    self.characterLimit = GSLimitPolicy.normalizedLimit(limit)
  }

  var body: some View {
    LimitLengthSecureField(text: $text,
                           numberOfCharacterLimit: characterLimit)
  }
}
