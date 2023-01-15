//
//  GoogleStyleTextField.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

public struct GoogleStyleTextField: View {
  enum ColorStyle {
    case active
    case normal
    case error
    case nonError
    
    var color: Color {
      switch self {
      case .active:
        return .blue
      case .normal:
        return .gray
      case .error:
        return .red
      case .nonError:
        return .clear
      }
    }
  }
  
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
  private let isSecure: Bool
  
  public init(text: Binding<String>,
              placeholder: String,
              isFocused: FocusState<Bool>.Binding,
              errorMessage: Binding<String>,
              description: String = "",
              isSecure: Bool = false) {
    
    self._text = text
    self._errorMessage = errorMessage
    self.placeholder = placeholder
    self.color = text.wrappedValue.isEmpty ? ColorStyle.normal.color : ColorStyle.active.color
    self.offsetY = text.wrappedValue.isEmpty ? .center : .top
    self.isFocused = isFocused
    self.description = description
    self.isSecure = isSecure
  }

  public var body: some View {
    VStack {
      ZStack {
        GoogleStyleRoundedBorder(color: $color)
        GoogleStylePlaceholder(placeholder: placeholder,
                               offsetY: $offsetY,
                               color: $color)
        if isSecure {
          SecureField("", text: $text)
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
        } else {
          TextField("", text: $text)
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
  
  private func configureColor(errorMessage: String, isFocused: Bool) {
    if !errorMessage.isEmpty {
      color = ColorStyle.error.color
    } else {
      color = isFocused ? ColorStyle.active.color : ColorStyle.normal.color
    }
  }
}
