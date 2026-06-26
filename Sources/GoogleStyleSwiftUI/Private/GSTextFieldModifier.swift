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
      .onChange(of: isFocused.wrappedValue, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: newValue,
                           errorMessage: errorMessage)
        }
      })
      .onChange(of: errorMessage, perform: { newValue in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: isFocused.wrappedValue,
                           errorMessage: newValue)
        }
      })
      .onChange(of: text, perform: { _ in
        withAnimation(.easeInOut(duration: 0.15)) {
          synchronizeState(isFocused: isFocused.wrappedValue,
                           errorMessage: errorMessage)
        }
      })
      .padding(EdgeInsets(top: 10,
                          leading: 15,
                          bottom: 10,
                          trailing: 15))
  }

  private func synchronizeState(isFocused: Bool, errorMessage: String) {
    offsetY = isFocused || !text.isEmpty ? .top : .center
    configureColor(errorMessage: errorMessage, isFocused: isFocused)
  }
  
  private func configureColor(errorMessage: String, isFocused: Bool) {
    if !errorMessage.isEmpty {
      color = GSColorStyle.error.color
    } else {
      color = isFocused ? GSColorStyle.active.color : GSColorStyle.normal.color
    }
  }
}
