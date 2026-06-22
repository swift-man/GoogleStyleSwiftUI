//
//  GSBottomTextModifier.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/16.
//

import SwiftUI

struct GSBottomTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(height: 18)
      .padding(EdgeInsets(top: 4,
                          leading: 0,
                          bottom: 18,
                          trailing: 0))
  }
}
