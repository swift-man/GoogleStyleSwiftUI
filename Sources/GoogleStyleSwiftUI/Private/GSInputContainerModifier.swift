import SwiftUI

struct GSInputContainerModifier: ViewModifier {
  private enum Layout {
    static let padding = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    static let cornerRadius: CGFloat = 12
  }

  let background: Color?

  @ViewBuilder
  func body(content: Content) -> some View {
    if let background {
      content
        .padding(Layout.padding)
        .background(background, in: RoundedRectangle(cornerRadius: Layout.cornerRadius, style: .continuous))
    } else {
      content
    }
  }
}
