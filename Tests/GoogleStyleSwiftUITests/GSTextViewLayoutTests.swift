#if os(iOS)
import SwiftUI
import UIKit
import XCTest
@testable import GoogleStyleSwiftUI

@MainActor
final class GSTextViewLayoutTests: XCTestCase {
  func testCompactEditorHasRoomForOneLineAtMaximumDynamicType() throws {
    try assertLineFits(CompactEditor().frame(width: 320, height: 143))
  }

  func testIntrinsicHeightFitsInheritedLargeTitle() throws {
    try assertLineFits(CompactEditor().font(.largeTitle).fixedSize(horizontal: false, vertical: true))
  }

  func testFocusedMultilineHintReservesVerticalInsets() async throws {
    let hint = "First\nSecond\nThird"
    let host = UIHostingController(rootView: HintEditor(hint: hint)
      .fixedSize(horizontal: false, vertical: true)
      .environment(\.dynamicTypeSize, .accessibility5))
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 350, height: 700))
    window.rootViewController = host
    window.makeKeyAndVisible()
    defer { window.isHidden = true }
    host.view.layoutIfNeeded()
    let editor = try XCTUnwrap(findTextView(in: host.view))
    let ready = NSPredicate { _, _ in editor.isFirstResponder }
    await fulfillment(of: [XCTNSPredicateExpectation(predicate: ready, object: nil)], timeout: 5)
    host.view.layoutIfNeeded()

    let label = UIHostingController(rootView: Text(hint).font(.body)
      .environment(\.dynamicTypeSize, .accessibility5))
    let hintHeight = label.sizeThatFits(in: CGSize(width: 300, height: 700)).height
    XCTAssertGreaterThanOrEqual(editor.bounds.height + 1, hintHeight + 16)
  }

  private func assertLineFits(_ content: some View) throws {
    let host = UIHostingController(rootView: content.environment(\.dynamicTypeSize, .accessibility5))
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
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
  }
}
private struct HintEditor: View {
  let hint: String
  @FocusState private var focused: Bool

  var body: some View {
    GSTextView(text: .constant(""), placeholder: "Label", editingPlaceholder: hint,
               isFocused: $focused, errorMessage: .constant(""), description: "Description", minHeight: 45)
      .onAppear { focused = true }
  }
}
#endif
