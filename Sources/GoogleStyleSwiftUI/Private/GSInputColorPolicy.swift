import SwiftUI

enum GSInputColorPolicy {
  static func color(errorMessage: String, isFocused: Bool) -> Color {
    if !errorMessage.isEmpty {
      return GSColorStyle.error.color
    }

    return isFocused ? GSColorStyle.active.color : GSColorStyle.normal.color
  }
}
