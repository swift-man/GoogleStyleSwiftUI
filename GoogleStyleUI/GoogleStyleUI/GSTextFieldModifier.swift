//
//  GSTextFieldModifier.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/16.
//

import SwiftUI

struct GSTextFieldModifier: ViewModifier {
  private var isFocused: FocusState<Bool>.Binding
  
  @Binding
  private var text: String
  
  @Binding
  private var errorMessage: String
  
  @Binding
  private var color: Color

  @Binding
  private var offsetY: GSPlaceholder.OffsetY
  
  init(isFocused: FocusState<Bool>.Binding,
       text: Binding<String>,
       editingPlaceholder: String,
       errorMessage: Binding<String>,
       color: Binding<Color>,
       offsetY: Binding<GSPlaceholder.OffsetY>) {
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
      .onChange(of: errorMessage, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          configureColor(errorMessage: newValue, isFocused: isFocused.wrappedValue)
        }
      })
      .padding(EdgeInsets(top: 5,
                          leading: 15,
                          bottom: 5,
                          trailing: 15))
  }
  
  private func configureColor(errorMessage: String, isFocused: Bool) {
    if !errorMessage.isEmpty {
      color = GSColorStyle.error.color
    } else {
      color = isFocused ? GSColorStyle.active.color : GSColorStyle.normal.color
    }
  }
}
