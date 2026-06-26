//
//  GSMultilineTextField.swift
//  GoogleStyleUI
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
public struct GSMultilineTextField: View {

  private enum Layout {
    static let minimumHeight: CGFloat = 45
    static let horizontalTextPadding: CGFloat = 15
    static let floatingTextTopPadding: CGFloat = 10
    static let collapsedTextTopPadding: CGFloat = 5
    static let textBottomPadding: CGFloat = 7
    static let floatingLabelXOffset: CGFloat = GSFloatingLabelMetrics.floatingHorizontalOffset
    static let floatingLabelYOffset: CGFloat = GSFloatingLabelMetrics.topLineCenteredYOffset
    static let collapsedLabelXOffset: CGFloat = 15
    static let collapsedLabelYOffset: CGFloat = 11
    static let editingPlaceholderXOffset: CGFloat = 17
    static let editingPlaceholderYOffset: CGFloat = 12
  }

  private var isFocused: FocusState<Bool>.Binding

  @Binding
  private var text: String

  @Binding
  private var errorMessage: String

  @State
  private var color: Color

  @State
  private var isPlaceholderFloating: Bool

  private let placeholder: String
  private let editingPlaceholder: String
  private let description: String
  private let background: Color
  private let limit: Int
  private let lineLimit: ClosedRange<Int>

  public init(text: Binding<String>,
              limit: Int = 1000,
              placeholder: String,
              editingPlaceholder: String = "",
              isFocused: FocusState<Bool>.Binding,
              errorMessage: Binding<String>,
              description: String = "",
              background: Color = .background,
              lineLimit: ClosedRange<Int> = 1...8) {
    self._text = text
    self.limit = GSLimitPolicy.normalizedLimit(limit)
    self._errorMessage = errorMessage
    self.placeholder = placeholder
    self.editingPlaceholder = editingPlaceholder
    self.isFocused = isFocused
    self.description = description
    self.background = background
    self.lineLimit = Self.normalizedLineLimit(lineLimit)
    self._color = State(initialValue: GSInputColorPolicy.color(errorMessage: errorMessage.wrappedValue,
                                                               isFocused: isFocused.wrappedValue))
    self._isPlaceholderFloating = State(initialValue: !text.wrappedValue.isEmpty || isFocused.wrappedValue)
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .topLeading) {
        background

        GSRoundedBorder(color: $color)

        TextField("", text: $text, axis: .vertical)
          .lineLimit(lineLimit)
          .focused(isFocused)
          .textFieldStyle(.plain)
          .padding(EdgeInsets(top: isPlaceholderFloating ? Layout.floatingTextTopPadding : Layout.collapsedTextTopPadding,
                              leading: Layout.horizontalTextPadding,
                              bottom: Layout.textBottomPadding,
                              trailing: Layout.horizontalTextPadding))
          .background(background)

        placeholderView
          .allowsHitTesting(false)
        editingPlaceholderView
          .allowsHitTesting(false)
      }
      .padding(.top, isPlaceholderFloating ? 8 : 0)
      .frame(minHeight: Layout.minimumHeight)
      .onChange(of: isFocused.wrappedValue, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: newValue, errorMessage: errorMessage)
        }
      })
      .onChange(of: errorMessage, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: isFocused.wrappedValue, errorMessage: newValue)
        }
      })
      .onChange(of: text, perform: { newValue in
        enforceLimit(newValue)

        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: isFocused.wrappedValue, errorMessage: errorMessage)
        }
      })

      if !errorMessage.isEmpty {
        GSErrorMessage(errorMessage: errorMessage)
      } else if !description.isEmpty {
        GSText(description: description)
      }
    }
  }

  private var placeholderView: some View {
    Text(placeholder)
      .padding(EdgeInsets(top: 0,
                          leading: isPlaceholderFloating ? GSFloatingLabelMetrics.floatingLeadingPadding : 0,
                          bottom: 0,
                          trailing: 5))
      .background(isPlaceholderFloating ? background : .clear)
      .font(isPlaceholderFloating ? Font.body : Font.title3)
      .foregroundColor(isPlaceholderFloating ? color : GSColorStyle.normal.color)
      .offset(x: isPlaceholderFloating ? Layout.floatingLabelXOffset : Layout.collapsedLabelXOffset,
              y: isPlaceholderFloating ? Layout.floatingLabelYOffset : Layout.collapsedLabelYOffset)
  }

  @ViewBuilder
  private var editingPlaceholderView: some View {
    if !editingPlaceholder.isEmpty && text.isEmpty && isPlaceholderFloating {
      Text(editingPlaceholder)
        .font(.body)
        .foregroundColor(GSColorStyle.normal.color)
        .background(background)
        .offset(x: Layout.editingPlaceholderXOffset,
                y: Layout.editingPlaceholderYOffset)
    }
  }

  private func synchronizeState(isFocused: Bool, errorMessage: String) {
    isPlaceholderFloating = isFocused || !text.isEmpty
    configureColor(errorMessage: errorMessage, isFocused: isFocused)
  }

  private func configureColor(errorMessage: String, isFocused: Bool) {
    color = GSInputColorPolicy.color(errorMessage: errorMessage, isFocused: isFocused)
  }

  private func enforceLimit(_ value: String) {
    guard value.count > limit else {
      return
    }

    text = String(value.prefix(limit))
  }

  private static func normalizedLineLimit(_ lineLimit: ClosedRange<Int>) -> ClosedRange<Int> {
    let lowerBound = max(1, lineLimit.lowerBound)
    let upperBound = max(lowerBound, lineLimit.upperBound)
    return lowerBound...upperBound
  }
}
