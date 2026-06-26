import SwiftUI

enum GSFloatingLabelMetrics {
  static let floatingHorizontalOffset: CGFloat = 11
  static let floatingLeadingPadding: CGFloat = 5
  static let topLineCenteredYOffset: CGFloat = -10

  static func centeredYOffset(containerHeight: CGFloat) -> CGFloat {
    -(containerHeight / 2)
  }
}
