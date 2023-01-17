//
//  GoogleStyleSecureField.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

public struct GoogleStyleSecureField: View {
  
  private var isFocused: FocusState<Bool>.Binding
  
  @Binding
  private var text: String
  
  @Binding
  private var errorMessage: String
  
  @State
  private var color: Color

  @State
  private var offsetY: GoogleStylePlaceholder.OffsetY
  
  private let placeholder: String
  private let description: String
  private let background: Color
  
  public init(text: Binding<String>,
              placeholder: String,
              isFocused: FocusState<Bool>.Binding,
              errorMessage: Binding<String>,
              description: String = "",
              background: Color = .background) {
    
    self._text = text
    self._errorMessage = errorMessage
    self.placeholder = placeholder
    self.color = text.wrappedValue.isEmpty ? ColorStyle.normal.color : ColorStyle.active.color
    self.offsetY = text.wrappedValue.isEmpty ? .center : .top
    self.isFocused = isFocused
    self.description = description
    self.background = background
  }

  public var body: some View {
    VStack {
      ZStack {
        GoogleStyleRoundedBorder(color: $color)
        GoogleStylePlaceholder(placeholder: placeholder,
                               offsetY: $offsetY,
                               foregroundColor: $color,
                               background: background)
        SecureField("", text: $text)
          .modifier(GoogleStyleTextFieldModifier(isFocused: isFocused,
                                                 text: $text,
                                                 errorMessage: $errorMessage,
                                                 color: $color,
                                                 offsetY: $offsetY))
      }
      .frame(height: 40)
      
      if !errorMessage.isEmpty {
        GoogleStyleErrorMessage(errorMessage: $errorMessage)
      } else {
        if !description.isEmpty {
          GoogleStyleText(description: description)
        }
      }
    }
  }
}
