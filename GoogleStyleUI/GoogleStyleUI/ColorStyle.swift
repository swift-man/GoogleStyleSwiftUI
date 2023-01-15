//
//  ColorStyle.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/15.
//

import SwiftUI

enum ColorStyle {
  case active
  case normal
  case error
  case nonError
  
  var color: Color {
    switch self {
    case .active:
      return .blue
    case .normal:
      return .gray
    case .error:
      return .red
    case .nonError:
      return .clear
    }
  }
}
