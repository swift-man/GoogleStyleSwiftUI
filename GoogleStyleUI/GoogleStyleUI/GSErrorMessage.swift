//
//  GSErrorMessage.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

struct GSErrorMessage: View {
  @Binding
  private var errorMessage: String
  
  init(errorMessage: Binding<String>) {
    self._errorMessage = errorMessage
  }
  
  private var errorForegroundColor: Color {
    if errorMessage.isEmpty {
      return GSColorStyle.nonError.color
    }
    
    return GSColorStyle.error.color
  }
  
  var body: some View {
    HStack() {
      Image(systemName: "exclamationmark.circle.fill")
        .foregroundColor(errorForegroundColor)
      Text(errorMessage)
        .foregroundColor(errorForegroundColor)
        .font(.system(size: 16, weight: .bold))
      Spacer()
    }
    .modifier(GSBottomTextModifier())
  }
}

struct GoogleStyleErrorMessage_Previews: PreviewProvider {
  @State
  static var message = "이름을 입력하세요."
  
  static var previews: some View {
    GSErrorMessage(errorMessage: $message)
  }
}
