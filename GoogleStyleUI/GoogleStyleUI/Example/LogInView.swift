//
//  LogInView.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/16.
//

import SwiftUI

struct LogInView: View {
  @State
  var text1 = ""
  
  @State
  var text2 = ""
  
  @State
  var errorMessage1 = ""
  
  @State
  var errorMessage2 = ""
  
  @FocusState
  private var isFocused1: Bool
  
  @FocusState
  private var isFocused2: Bool
  
  var body: some View {
    GSTextField(text: $text1,
                limit: 10,
                placeholder: "사용자 이름",
                editingPlaceholder: "10자리",
                isFocused: $isFocused1,
                errorMessage: $errorMessage1,
                description: "문자, 숫자, 마침표를 사용할 수 있습니다.")
    
    .padding(EdgeInsets(top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 10))
    
    GSSecureField(text: $text2,
                  placeholder: "비밀번호",
                  isFocused: $isFocused2,
                  errorMessage: $errorMessage2)
    .padding(EdgeInsets(top: 0,
                        leading: 10,
                        bottom: 0,
                        trailing: 10))
    .onChange(of: text1) { newValue in
      print("text1 : \(newValue)")
    }
    Button("Show Error1") {
      withAnimation(.easeInOut(duration: 0.15)) {
        if !errorMessage1.isEmpty {
          errorMessage1 = ""
        } else {
          errorMessage1 = "에러1"
        }
      }
    }
    .foregroundColor(.blue)
    Button("Show Error2") {
      withAnimation(.easeInOut(duration: 0.15)) {
        if !errorMessage2.isEmpty {
          errorMessage2 = ""
        } else {
          errorMessage2 = "에러2"
        }
      }
    }
    .foregroundColor(.blue)
    .navigationTitle("LoginView")
  }
}

struct LogInView_Previews: PreviewProvider {
  static var previews: some View {
    LogInView()
  }
}
