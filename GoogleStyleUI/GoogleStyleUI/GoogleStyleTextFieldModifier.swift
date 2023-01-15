//
//  GoogleStyleTextFieldModifier.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/16.
//

import SwiftUI

struct GoogleStyleTextFieldModifier: ViewModifier {
  private var isFocused: FocusState<Bool>.Binding
  
  @Binding
  private var text: String
  
  @Binding
  private var errorMessage: String
  
  @Binding
  private var color: Color

  @Binding
  private var offsetY: GoogleStylePlaceholder.OffsetY
  
  init(isFocused: FocusState<Bool>.Binding,
       text: Binding<String>,
       errorMessage: Binding<String>,
       color: Binding<Color>,
       offsetY: Binding<GoogleStylePlaceholder.OffsetY>) {
    self.isFocused = isFocused
    self._text = text
    self._errorMessage = errorMessage
    self._color = color
    self._offsetY = offsetY
  }
  
  func body(content: Content) -> some View {
    content
      .focused(isFocused)
      .onChange(of: isFocused.wrappedValue) { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          if newValue {
            offsetY = .top
          } else {
            offsetY = text.isEmpty ? .center : .top
          }
          
          configureColor(errorMessage: errorMessage, isFocused: newValue)
        }
      }
      .onChange(of: errorMessage) { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          configureColor(errorMessage: newValue, isFocused: isFocused.wrappedValue)
        }
      }
      .padding()
  }
  
  private func configureColor(errorMessage: String, isFocused: Bool) {
    if !errorMessage.isEmpty {
      color = ColorStyle.error.color
    } else {
      color = isFocused ? ColorStyle.active.color : ColorStyle.normal.color
    }
  }
}
