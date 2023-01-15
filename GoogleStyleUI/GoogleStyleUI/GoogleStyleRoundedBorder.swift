//
//  GoogleStyleRoundedBorder.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

struct GoogleStyleRoundedBorder: View {
  @Binding
  private var color: Color
  
  init(color: Binding<Color>) {
    self._color = color
  }
  
  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .stroke(color, lineWidth: color == Color.blue ? 2 : 1)
  }
}

struct GoogleStyleRoundedBorder_Previews: PreviewProvider {
  @State
  static var color = Color.blue
  
  static var previews: some View {
    GoogleStyleRoundedBorder(color: $color)
  }
}
