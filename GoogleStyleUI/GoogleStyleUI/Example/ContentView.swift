//
//  ContentView.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/14.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      Form {
        NavigationLink("TextField") {
          LogInView()
        }
        NavigationLink("Picker") {
          // https://myaccount.google.com/birthday?hl=ko
          LogInView()
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
