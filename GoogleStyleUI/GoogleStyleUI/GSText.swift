//
//  GSText.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

struct GSText: View {
  private var description: String
  
  init(description: String) {
    self.description = description
  }
  
  var body: some View {
    HStack {
      Text(description)
        .foregroundColor(GSColorStyle.normal.color)
        .font(.system(size: 14, weight: .regular))
        .padding(EdgeInsets(top: 0,
                            leading: 10,
                            bottom: 0,
                            trailing: 0))
      Spacer()
    }
    .modifier(GSBottomTextModifier())
  }
}

struct GoogleStyleText_Previews: PreviewProvider {
  static var previews: some View {
    GSText(description: "문자")
  }
}
