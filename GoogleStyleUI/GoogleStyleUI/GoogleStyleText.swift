//
//  GoogleStyleText.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

struct GoogleStyleText: View {
  private var description: String
  
  init(description: String) {
    self.description = description
  }
  
  var body: some View {
    HStack {
      Text(description)
        .foregroundColor(ColorStyle.normal.color)
        .font(.system(size: 14, weight: .regular))
        .padding(EdgeInsets(top: 0,
                            leading: 10,
                            bottom: 0,
                            trailing: 0))
      Spacer()
    }
    .modifier(GoogleStyleBottomTextModifier())
  }
}

struct GoogleStyleText_Previews: PreviewProvider {
  static var previews: some View {
    GoogleStyleText(description: "문자")
  }
}
