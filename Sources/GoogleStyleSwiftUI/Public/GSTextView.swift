//
//  GSTextView.swift
//  GoogleStyleUI
//

import SwiftUI

public struct GSTextView: View {

  private enum Layout {
    static let horizontalTextPadding: CGFloat = 11
    static let floatingTextTopPadding: CGFloat = 15
    static let collapsedTextTopPadding: CGFloat = 10
    static let textBottomPadding: CGFloat = 12
    static let floatingLabelXOffset: CGFloat = GSFloatingLabelMetrics.floatingHorizontalOffset
    static let floatingLabelYOffset: CGFloat = GSFloatingLabelMetrics.topLineCenteredYOffset
    static let collapsedLabelXOffset: CGFloat = 15
    static let collapsedLabelYOffset: CGFloat = 11
    static let editingPlaceholderXOffset: CGFloat = 17
    static let editingPlaceholderYOffset: CGFloat = 23
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
  private let containerBackground: Color?
  private let limit: Int
  private let minHeight: CGFloat

  /// Google style long-form text editor with floating placeholder and max length support.
  ///
  /// Use `GSTextView` for long body text. Use `GSMultilineTextField` when you need
  /// SwiftUI's multiline `TextField(axis: .vertical)` behavior.
  /// If a non-positive `limit` is provided, the effective limit is normalized to `1`.
  public init(text: Binding<String>,
              limit: Int = 4000,
              placeholder: String,
              editingPlaceholder: String = "",
              isFocused: FocusState<Bool>.Binding,
              errorMessage: Binding<String>,
              description: String = "",
              background: Color = .background,
              containerBackground: Color? = nil,
              minHeight: CGFloat = 120) {
    self._text = text
    self.limit = GSLimitPolicy.normalizedLimit(limit)
    self._errorMessage = errorMessage
    self.placeholder = placeholder
    self.editingPlaceholder = editingPlaceholder
    self.isFocused = isFocused
    self.description = description
    self.background = background
    self.containerBackground = containerBackground
    self.minHeight = max(45, minHeight)
    self._color = State(initialValue: GSInputColorPolicy.color(errorMessage: errorMessage.wrappedValue,
                                                               isFocused: isFocused.wrappedValue))
    self._isPlaceholderFloating = State(initialValue: !text.wrappedValue.isEmpty || isFocused.wrappedValue)
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .topLeading) {
        background

        TextEditor(text: $text)
          .focused(isFocused)
          .padding(EdgeInsets(top: isPlaceholderFloating ? Layout.floatingTextTopPadding : Layout.collapsedTextTopPadding,
                              leading: Layout.horizontalTextPadding,
                              bottom: Layout.textBottomPadding,
                              trailing: Layout.horizontalTextPadding))
          .frame(minHeight: minHeight)
          .gsTextEditorBackground(background)

        GSRoundedBorder(color: $color)
          .allowsHitTesting(false)

        placeholderView
          .allowsHitTesting(false)
        editingPlaceholderView
          .allowsHitTesting(false)
      }
      .padding(.top, isPlaceholderFloating ? 8 : 0)
      .frame(minHeight: minHeight)
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
    .modifier(GSInputContainerModifier(background: containerBackground))
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
}

public typealias GSTextEditor = GSTextView

private extension View {
  @ViewBuilder
  func gsTextEditorBackground(_ background: Color) -> some View {
    if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
      self
        .scrollContentBackground(.hidden)
        .background(background)
    } else {
      self.background(background)
    }
  }
}
