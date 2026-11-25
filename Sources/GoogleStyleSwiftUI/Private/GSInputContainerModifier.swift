import SwiftUI

struct GSInputContainerModifier: ViewModifier {
  private enum Layout {
    static let cornerRadius: CGFloat = 12
  }

  static let defaultVerticalPadding: CGFloat = 16

  let background: Color?
  var verticalPadding: CGFloat = defaultVerticalPadding

  @ViewBuilder
  func body(content: Content) -> some View {
    if let background {
      content
        .padding(.horizontal, 16)
        .padding(.vertical, verticalPadding)
        .background(background, in: RoundedRectangle(cornerRadius: Layout.cornerRadius, style: .continuous))
    } else {
      content
    }
  }
}
