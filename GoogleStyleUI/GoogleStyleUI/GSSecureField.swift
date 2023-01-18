//
//  GSSecureField.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI
import LimitLengthTextField

public struct GSSecureField: View {
  
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
  
  public init(text: Binding<String>,
              placeholder: String,
              editingPlaceholder: String = "",
              limit: Int = 100,
              isFocused: FocusState<Bool>.Binding,
              errorMessage: Binding<String>,
              description: String = "",
              background: Color = .background) {
    
    self._text = text
    self.limit = limit
    self._errorMessage = errorMessage
    self.placeholder = placeholder
    self.color = text.wrappedValue.isEmpty ? GSColorStyle.normal.color : GSColorStyle.active.color
    self.offsetY = text.wrappedValue.isEmpty ? .center : .top
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
        LimitLengthSecureField(text: $text,
                               numberOfCharacterLimit: limit)
        .modifier(GSTextFieldModifier(isFocused: isFocused,
                                               text: $text,
                                               editingPlaceholder: editingPlaceholder,
                                               errorMessage: $errorMessage,
                                               color: $color,
                                               offsetY: $offsetY))
      }
      .frame(height: 40)
      
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
