//
//  GSMultilineTextField.swift
//  GoogleStyleUI
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
public struct GSMultilineTextField: View {

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
    self._color = State(initialValue: text.wrappedValue.isEmpty ? GSColorStyle.normal.color : GSColorStyle.active.color)
    self._isPlaceholderFloating = State(initialValue: !text.wrappedValue.isEmpty)
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ZStack(alignment: .topLeading) {
        GSRoundedBorder(color: $color)

        TextField("", text: $text, axis: .vertical)
          .lineLimit(lineLimit)
          .focused(isFocused)
          .padding(EdgeInsets(top: isPlaceholderFloating ? 16 : 5,
                              leading: 15,
                              bottom: 5,
                              trailing: 15))

        placeholderView
        editingPlaceholderView
      }
      .padding(.top, isPlaceholderFloating ? 8 : 0)
      .frame(minHeight: 45)
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
                          leading: isPlaceholderFloating ? 5 : 0,
                          bottom: 0,
                          trailing: 5))
      .background(isPlaceholderFloating ? background : .clear)
      .font(isPlaceholderFloating ? Font.body : Font.title3)
      .foregroundColor(isPlaceholderFloating ? color : GSColorStyle.normal.color)
      .offset(x: isPlaceholderFloating ? 11 : 15,
              y: isPlaceholderFloating ? -1 : 11)
  }

  @ViewBuilder
  private var editingPlaceholderView: some View {
    if !editingPlaceholder.isEmpty && text.isEmpty && isPlaceholderFloating {
      Text(editingPlaceholder)
        .foregroundColor(GSColorStyle.normal.color)
        .offset(x: 17, y: 24)
    }
  }

  private func synchronizeState(isFocused: Bool, errorMessage: String) {
    isPlaceholderFloating = isFocused || !text.isEmpty
    configureColor(errorMessage: errorMessage, isFocused: isFocused)
  }

  private func configureColor(errorMessage: String, isFocused: Bool) {
    if !errorMessage.isEmpty {
      color = GSColorStyle.error.color
    } else {
      color = isFocused ? GSColorStyle.active.color : GSColorStyle.normal.color
    }
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
