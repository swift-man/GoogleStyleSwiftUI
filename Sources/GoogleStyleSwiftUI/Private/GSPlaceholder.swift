//
//  GoogleStylePlaceholder.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

struct GSPlaceholder: View {
  enum OffsetY {
    case top
    case center
  }
  private let placeholder: String
  
  private let background: Color
  
  @Binding
  private var foregroundColor: Color
  
  @Binding
  private var offsetY: OffsetY
  
  init(placeholder: String,
       offsetY: Binding<OffsetY>,
       foregroundColor: Binding<Color>,
       background: Color) {
    self._offsetY = offsetY
    self._foregroundColor = foregroundColor
    self.placeholder = placeholder
    self.background = background
  }
  
  var body: some View {
      HStack {
        Text(placeholder)
          .padding(EdgeInsets(top: 0,
                              leading: offsetY == .top ? 5 : 0,
                              bottom: 0,
                              trailing: 5))
          .frame(alignment: .leading)
          .background(background)
          .font(offsetY == .top ? Font.body : Font.title3)
          .foregroundColor(offsetY == .top ? foregroundColor : GSColorStyle.normal.color)
          .offset(x: offsetY == .top ? 6 : 15, y: offsetY == .top ? -27 : 0)

        Spacer()
      }
  }
}

struct GoogleStylePlaceholder_Previews: PreviewProvider {
  @State
  static var offsetY = GSPlaceholder.OffsetY.center
  
  @State
  static var color = Color.gray
  
  static var previews: some View {
    GSPlaceholder(placeholder: "placeholder",
                           offsetY: $offsetY,
                           foregroundColor: $color,
                           background: .white)
  }
}
