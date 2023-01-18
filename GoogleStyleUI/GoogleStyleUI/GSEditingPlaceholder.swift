//
//  GSEditingPlaceholder.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/19.
//

import SwiftUI

struct GSEditingPlaceholder: View {
  
  private let editingPlaceholder: String
  
  @Binding
  private var text: String
  
  @Binding
  private var offsetY: GSPlaceholder.OffsetY
  
  init(text: Binding<String>,
       editingPlaceholder: String,
       offsetY: Binding<GSPlaceholder.OffsetY>) {
    self._text = text
    self._offsetY = offsetY
    self.editingPlaceholder = editingPlaceholder
  }

  public var body: some View {
    if !editingPlaceholder.isEmpty && text.isEmpty && offsetY == .top {
      HStack {
        Text(editingPlaceholder)
          .offset(x: 17)
          .foregroundColor(GSColorStyle.normal.color)
        Spacer()
      }
    }
  }
}
