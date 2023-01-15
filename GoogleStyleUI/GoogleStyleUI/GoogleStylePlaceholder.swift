//
//  GoogleStylePlaceholder.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

struct GoogleStylePlaceholder: View {
  enum OffsetY {
    case top
    case center
  }
  private let placeholder: String
  
  @Binding
  private var color: Color
  
  @Binding
  private var offsetY: OffsetY
  
  init(placeholder: String,
       offsetY: Binding<OffsetY>,
       color: Binding<Color>) {
    self._offsetY = offsetY
    self._color = color
    self.placeholder = placeholder
  }
  
  var body: some View {
      HStack {
        Text(placeholder)
          .padding(EdgeInsets(top: 0,
                              leading: offsetY == .top ? 4 : 0,
                              bottom: 0,
                              trailing: 5))
          .frame(alignment: .leading)
          .background(.white)
          .font(offsetY == .top ? Font.body : Font.title3)
          .foregroundColor(offsetY == .top ? color : ColorStyle.normal.color)
          .offset(x: offsetY == .top ? 6 : 10, y: offsetY == .top ? -31 : 0)

        Spacer()
      }
  }
}

struct GoogleStylePlaceholder_Previews: PreviewProvider {
  @State
  static var offsetY = GoogleStylePlaceholder.OffsetY.center
  
  @State
  static var color = Color.gray
  
  static var previews: some View {
    GoogleStylePlaceholder(placeholder: "placeholder",
                           offsetY: $offsetY,
                           color: $color)
  }
}
