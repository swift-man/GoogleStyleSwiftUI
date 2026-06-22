//
//  GSTextField.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

public struct GSTextField: View {
  
  private var isFocused: FocusState<Bool>.Binding
  
  @Binding
  private var text: String
  
  @Binding
  private var errorMessage: String
  
  @State
  private var color: Color

  @State
  private var offsetY: GSPlaceholder.OffsetY
  
  private let placeholder: String
  private let editingPlaceholder: String
  private let description: String
  private let background: Color
  private let limit: Int

  /// Google style text input with floating placeholder and max length support.
  ///
  /// The `limit` value controls the maximum character count.
  /// If a non-positive value is provided, the effective limit is normalized to `1`.
  public init(text: Binding<String>,
              limit: Int = 100,
              placeholder: String,
              editingPlaceholder: String = "",
              isFocused: FocusState<Bool>.Binding,
              errorMessage: Binding<String>,
              description: String = "",
              background: Color = .background) {
    
    self._text = text
    self.limit = limit
    self._errorMessage = errorMessage
    self.placeholder = placeholder
    self._color = State(initialValue: text.wrappedValue.isEmpty ? GSColorStyle.normal.color : GSColorStyle.active.color)
    self._offsetY = State(initialValue: text.wrappedValue.isEmpty ? .center : .top)
    self.isFocused = isFocused
    self.description = description
    self.background = background
    self.editingPlaceholder = editingPlaceholder
  }

  public var body: some View {
    VStack {
      ZStack {
        GSRoundedBorder(color: $color)
        GSPlaceholder(placeholder: placeholder,
                      offsetY: $offsetY,
                      foregroundColor: $color,
                      background: background)
        GSLimitedLengthTextField(text: $text,
                                 limit: limit)
        .modifier(GSTextFieldModifier(isFocused: isFocused,
                                      text: $text,
                                      errorMessage: $errorMessage,
                                      color: $color,
                                      offsetY: $offsetY))
        GSEditingPlaceholder(text: $text,
                             editingPlaceholder: editingPlaceholder,
                             offsetY: $offsetY)
      }
      .frame(height: 45)
      
      if !errorMessage.isEmpty {
        GSErrorMessage(errorMessage: $errorMessage)
      } else {
        if !description.isEmpty {
          GSText(description: description)
        }
      }
    }
  }
}
