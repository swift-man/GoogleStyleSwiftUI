#if os(iOS)
import SwiftUI
import UIKit
import XCTest
@testable import GoogleStyleSwiftUI

@MainActor
final class GSTextViewLayoutTests: XCTestCase {
  func testCompactEditorHasRoomForOneLineAtMaximumDynamicType() throws {
    let host = UIHostingController(rootView: CompactEditor()
      .environment(\.dynamicTypeSize, .accessibility5))
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 350, height: 160))
    window.rootViewController = host
    window.isHidden = false
    defer { window.isHidden = true }
    host.view.layoutIfNeeded()

    let editor = try XCTUnwrap(findTextView(in: host.view))
    let font = try XCTUnwrap(editor.font)
    let availableHeight = editor.bounds.height - editor.textContainerInset.top - editor.textContainerInset.bottom
    XCTAssertGreaterThanOrEqual(availableHeight + 1, font.lineHeight)
  }

  private func findTextView(in view: UIView) -> UITextView? {
    if let editor = view as? UITextView { return editor }
    return view.subviews.lazy.compactMap { self.findTextView(in: $0) }.first
  }
}

private struct CompactEditor: View {
  @FocusState private var focused: Bool

  var body: some View {
    GSTextView(text: .constant("Hello"), placeholder: "자주 쓰는 텍스트 입력",
               isFocused: $focused, errorMessage: .constant(""),
               containerBackground: .white, minHeight: 45)
      .frame(width: 320, height: 143)
  }
}
#endif
