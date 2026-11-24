import SwiftUI

struct GSInputContainerModifier: ViewModifier {
  private enum Layout {
    static let cornerRadius: CGFloat = 12
  }

  let background: Color?
  var verticalPadding: CGFloat = 16

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
