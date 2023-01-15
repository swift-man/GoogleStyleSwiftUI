//
//  ContentView.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/14.
//

import SwiftUI

struct ContentView: View {
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
    GoogleStyleTextField(text: $text1,
                         placeholder: "사용자 이름",
                         isFocused: $isFocused1,
                         errorMessage: $errorMessage1,
                         description: "문자, 숫자, 마침표를 사용할 수 있습니다.")
//    .padding()
    GoogleStyleSecureField(text: $text2,
                           placeholder: "비밀번호",
                           isFocused: $isFocused2,
                           errorMessage: $errorMessage2,
                           description: "")
//    .padding()
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
    Button("Show Error2") {
      withAnimation(.easeInOut(duration: 0.15)) {
        if !errorMessage2.isEmpty {
          errorMessage2 = ""
        } else {
          errorMessage2 = "에러2"
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
