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

  func testFontMeasurementDoesNotExpandNarrowEditor() {
    let host = UIHostingController(rootView: CompactEditor(placeholder: "")
      .font(.largeTitle).environment(\.dynamicTypeSize, .accessibility5))
    let proposal = CGSize(width: 80, height: 350)
    XCTAssertLessThanOrEqual(host.sizeThatFits(in: proposal).width, proposal.width + 1)
  }

  func testFocusedMultilineHintReservesVerticalInsets() async throws {
    try await assertHintFits("First\nSecond\nThird", size: .accessibility5, width: 350, verticalInsets: 16)
  }

  func testWrappedHintReservesTopInsetAtDefaultSize() async throws {
    try await assertHintFits("First second third fourth fifth sixth", size: .large, width: 110, verticalInsets: 23)
  }

  private func assertHintFits(_ hint: String, size: DynamicTypeSize, width: CGFloat, verticalInsets: CGFloat) async throws {
    let host = UIHostingController(rootView: HintEditor(hint: hint)
      .fixedSize(horizontal: false, vertical: true)
      .environment(\.dynamicTypeSize, size))
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: 700))
    window.rootViewController = host
    window.makeKeyAndVisible()
    defer { window.isHidden = true }
    host.view.layoutIfNeeded()
    let editor = try XCTUnwrap(findTextView(in: host.view))

    let label = UIHostingController(rootView: Text(hint).font(.body)
      .environment(\.dynamicTypeSize, size))
    let hintHeight = label.sizeThatFits(in: CGSize(width: width - 28, height: 700)).height
    let minimumHeight = hintHeight + verticalInsets
    // The editor itself has extra vertical padding in the standard layout.
    let editorPadding: CGFloat = size.isAccessibilitySize ? 0 : 27
    let ready = NSPredicate { _, _ in
      host.view.layoutIfNeeded()
      return editor.isFirstResponder && editor.bounds.height + editorPadding + 1 >= minimumHeight
    }
    await fulfillment(of: [XCTNSPredicateExpectation(predicate: ready, object: nil)], timeout: 5)
    XCTAssertTrue(editor.isFirstResponder)
    XCTAssertGreaterThanOrEqual(editor.bounds.height + editorPadding + 1, minimumHeight)
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
  var placeholder = "자주 쓰는 텍스트 입력"
  @FocusState private var focused: Bool

  var body: some View {
    GSTextView(text: .constant("Hello"), placeholder: placeholder,
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
